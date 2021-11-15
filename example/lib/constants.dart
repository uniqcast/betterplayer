class Constants {
  static const String bugBuckBunnyVideoUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  static const String forBiggerBlazesUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
  static const String fileTestVideoUrl = "testvideo.mp4";
  static const String fileTestVideoEncryptUrl = "testvideo_encrypt.mp4";
  static const String networkTestVideoEncryptUrl =
      "https://github.com/tinusneethling/betterplayer/raw/ClearKeySupport/example/assets/testvideo_encrypt.mp4";
  static const String fileExampleSubtitlesUrl = "example_subtitles.srt";
  static const String hlsTestStreamUrl =
      "https://fairplay-test.uniqcast.com:8080/demo/master_playlist.m3u8";
  static const String hlsPlaylistUrl =
      "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8";
  static const Map<String, String> exampleResolutionsUrls = {
    "LOW":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
    "MEDIUM":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4",
    "LARGE":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4",
    "EXTRA_LARGE":
        "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1920_18MG.mp4"
  };
  static const String phantomVideoUrl =
      "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8";
  static const String elephantDreamVideoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";
  static const String forBiggerJoyridesVideoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4";
  static const String verticalVideoUrl =
      "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4";
  static String logo = "logo.png";
  static String placeholderUrl =
      "https://imgix.bustle.com/uploads/image/2020/8/5/23905b9c-6b8c-47fa-bc0f-434de1d7e9bf-avengers-5.jpg";
  static String elephantDreamStreamUrl =
      "http://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8";
  static String tokenEncodedHlsUrl =
      "https://amssamples.streaming.mediaservices.windows.net/830584f8-f0c8-4e41-968b-6538b9380aa5/TearsOfSteelTeaser.ism/manifest(format=m3u8-aapl)";
  static String tokenEncodedHlsToken =
      "Bearer=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1cm46bWljcm9zb2Z0OmF6dXJlOm1lZGlhc2VydmljZXM6Y29udGVudGtleWlkZW50aWZpZXIiOiI5ZGRhMGJjYy01NmZiLTQxNDMtOWQzMi0zYWI5Y2M2ZWE4MGIiLCJpc3MiOiJodHRwOi8vdGVzdGFjcy5jb20vIiwiYXVkIjoidXJuOnRlc3QiLCJleHAiOjE3MTA4MDczODl9.lJXm5hmkp5ArRIAHqVJGefW2bcTzd91iZphoKDwa6w8";
  static String widevineVideoUrl =
      "https://storage.googleapis.com/wvmedia/cenc/h264/tears/tears_sd.mpd";
  static String widevineLicenseUrl =
      "https://proxy.uat.widevine.com/proxy?provider=widevine_test";

  static String fairplayHlsUrl =
      "http://fairplay-test.uniqcast.com:11313/auth-streaming/2,b487c8612a4e9b0e963831ae65f136a567365967,1637082497,jjones,0-novatv,8,8,8,8,8,8,DESKTOP,15,all,none,default,192.168.0.178/playlist/0-novatv/live/index.m3u8";
  static String fairplayCertificateUrl =
      "http://fairplay-test.uniqcast.com:11313/drmproxy/fp/cert";
  static String fairplayLicenseUrl = "http://fairplay-test.uniqcast.com:11313/drmproxy/fp/license?lat=2I8mtqM5%2F6IdGKu2vcuU8so1x41ZiXF2F5tiLhAyShEi036TZ23aWZ01N3IaVMb4g0SkzkHFJSEGQpDcqZ4z%2FlvTKzV%2FxG%2FxSD3eCqtxQrEbAswwh8D6x%2B2U0j6funklbzIlhwvpkCqSmOGwHHuy9HG7szmEBanF7D8OCvP7C6kOHgYVYmdny%2BIhvZbEdVIRm3O2xhvvKWTM7zvcqCuYIgTa0i%2FeMKEO7QEsCHiEgU4%3D&jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjIsInVuYW1lIjoiampvbmVzIiwicGFzcyI6IjA3NTY4MTAyODk4MTQzNjJlZmJlYThiYjgyNmZlYTBhN2JjNDMxOGE3ZjIyYTRiMjdiNDgyOTBjZDM5OTUxYTMiLCJyb2xlIjpbInN1YnNjcmliZXIiXSwiZGlkIjoxNSwiZHVpZCI6Im1hY3Rlc3QiLCJvaWQiOjEsIm91aWQiOiJkZWZhdWx0IiwicmlkIjoxLCJydWlkIjoiZGVmYXVsdCIsInBuYW1lIjoiSmVzc2ljYSIsIm1waW4iOiIwM2FjNjc0MjE2ZjNlMTVjNzYxZWUxYTVlMjU1ZjA2Nzk1MzYyM2M4YjM4OGI0NDU5ZTEzZjk3OGQ3Yzg0NmY0IiwicHBpbiI6IjEyMzQiLCJpYXQiOjE2MzY5OTYwNzcsImV4cCI6MTYzNjk5Nzg3NywiaXNzIjoidW5pcUNhc3QiLCJzdWIiOiJsb2dpbiJ9.gQXOoxjsyy1wNihXoktBSG_EXywnL8_grlkIAtE2TnM";


  static String catImageUrl =
      "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg";
  static String dashStreamUrl =
      "https://bitmovin-a.akamaihd.net/content/sintel/sintel.mpd";
  static String segmentedSubtitlesHlsUrl =
      "https://eng-demo.cablecast.tv/segmented-captions/vod.m3u8";
}
