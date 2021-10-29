// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "BetterPlayerAssetsLoaderDelegate.h"

@implementation BetterPlayerAssetsLoaderDelegate

NSString *_assetId;

NSString * DEFAULT_LICENSE_SERVER_URL = @"https://fps.ezdrm.com/api/licenses/";

- (instancetype)init:(NSURL *)certificateURL withLicenseURL:(NSURL *)licenseURL{
    self = [super init];
    _certificateURL = certificateURL;
    _licenseURL = licenseURL;
    return self;
}

/*------------------------------------------
 **
 ** getContentKeyAndLeaseExpiryFromKeyServerModuleWithRequest
 **
 ** Takes the bundled SPC and sends it to the license server defined at licenseUrl or KEY_SERVER_URL (if licenseUrl is null).
 ** It returns CKC.
 ** ---------------------------------------*/
- (NSData *)getContentKeyAndLeaseExpiryFromKeyServerModuleWithRequest:(NSData*)requestBytes and:(NSString *)assetId and:(NSString *)customParams and:(NSError *)errorOut {
    NSLog(@"Licence Fetch Started");
    NSData * responseData;
    NSURLResponse * response;
    
    NSURL * finalLicenseURL;
    finalLicenseURL = _licenseURL;

    NSLog(@"Generate URL");
    NSURL * ksmURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@",finalLicenseURL]];

    NSLog(@"Generate b64 spc");
    NSString *spc = [requestBytes base64EncodedStringWithOptions:0];
    if (spc != nil) {
        NSLog(@"Generate Payload");
        assetId = [assetId stringByReplacingOccurrencesOfString:@"skd://" withString:@""];
        NSDictionary *jsonBodyDict = @{@"spc":spc, @"assetId":assetId};
        NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
        
        NSLog(@"prepare request");
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:ksmURL];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [request setHTTPBody:jsonBodyData];



        @try {
            NSLog(@"Response Get");
            responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];

            NSError* error = nil;

            NSLog(@"parse response");
            NSString *strISOLatin = [[NSString alloc] initWithData:responseData encoding:NSISOLatin1StringEncoding];
            NSData *dataUTF8 = [strISOLatin dataUsingEncoding:NSUTF8StringEncoding];

            id dict = [NSJSONSerialization JSONObjectWithData:dataUTF8 options:0 error:&error];

            if (dict != nil) {
                NSString *ckcEncoded = [dict objectForKey:@"ckc"];
                NSData *ckc = [[NSData alloc]initWithBase64EncodedString:ckcEncoded options:0];
                return ckc;
            } else {
                NSLog(@"Error: %@", error);
            }
        }
        @catch (NSException* excp) {
            NSLog(@"SDK Error, SDK responded with Error: (error)");
        }
    }
    
}

/*------------------------------------------
 **
 ** getAppCertificate
 **
 ** returns the apps certificate for authenticating against your server
 ** the example here uses a local certificate
 ** but you may need to edit this function to point to your certificate
 ** ---------------------------------------*/
- (NSData *)getAppCertificate:(NSString *) String {
    NSData * certificate = nil;
    certificate = [NSData dataWithContentsOfURL:_certificateURL];
    return certificate;
}

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSURL *assetURI = loadingRequest.request.URL;
    NSString * str = assetURI.absoluteString;
    NSString * mySubstring = [str stringByReplacingOccurrencesOfString:@"skd://" withString:@""];
    _assetId = mySubstring;
    NSString * scheme = assetURI.scheme;
    NSData * requestBytes;
    NSData * certificate;
    if (!([scheme isEqualToString: @"skd"])){
        return NO;
    }
    @try {
        certificate = [self getAppCertificate:_assetId];
    }
    @catch (NSException* excp) {
        [loadingRequest finishLoadingWithError:[[NSError alloc] initWithDomain:NSURLErrorDomain code:NSURLErrorClientCertificateRejected userInfo:nil]];
    }
    @try {
        requestBytes = [loadingRequest streamingContentKeyRequestDataForApp:certificate contentIdentifier: [str dataUsingEncoding:NSUTF8StringEncoding] options:nil error:nil];
    }
    @catch (NSException* excp) {
        [loadingRequest finishLoadingWithError:nil];
        return YES;
    }
    
    NSString * passthruParams = [NSString stringWithFormat:@"?customdata=%@", _assetId];
    NSData * responseData;
    NSError * error;
    
    responseData = [self getContentKeyAndLeaseExpiryFromKeyServerModuleWithRequest:requestBytes and:_assetId and:passthruParams and:error];
    
    if (responseData != nil && responseData != NULL && ![responseData.class isKindOfClass:NSNull.class]){
        AVAssetResourceLoadingDataRequest * dataRequest = loadingRequest.dataRequest;
        [dataRequest respondWithData:responseData];
        [loadingRequest finishLoading];
    } else {
        [loadingRequest finishLoadingWithError:error];
    }
    
    return YES;
}

- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForRenewalOfRequestedResource:(AVAssetResourceRenewalRequest *)renewalRequest {
    return [self resourceLoader:resourceLoader shouldWaitForLoadingOfRequestedResource:renewalRequest];
}

@end
