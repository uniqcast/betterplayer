# uniqtv

## SETUP

 * Setup local SSH keys with bitbucket (need for pub get - fetching uniqapi package)
 * Copy .env.example into .env
 * Setup lefthook
    * https://github.com/evilmartians/lefthook/blob/master/docs/other.md#installation
    * run ```lefthook install``` in project root directory 

## IDE

 * Android Studio
   * Plugins:
      * https://plugins.jetbrains.com/plugin/6351-dart
      * https://plugins.jetbrains.com/plugin/9212-flutter
      * https://plugins.jetbrains.com/plugin/14442-flutter-toolkit
         * For build runner toolbar
   * Enable Format code on save and Organize imports on save in Preferences… -> Languages & Frameworks _> Flutter -> Editor
 * VS Code

## Run code generation
 * Need to run in after changes in _model.dart or _state.dart classes
 * CLI
    * flutter pub run build_runner build --delete-conflicting-outputs or can watch changes
    * flutter pub run build_runner watch --delete-conflicting-outputs
 * In android studio toolbar/shortcut using Flutter-Toolkit plugin

## AUTOMATION TESTS

### Integration tests

Integration tests are useful if we want to test how individual pieces work together as a whole ( Widgets ).

Integration tests are located in ```/integration_test``` directory and main file which contains all test groups is ```index_test.dart``` file.
Int. tests in application are designed to work with main test files (testname_test.dart) and their helper files which are seperated in their own directories.
For example, if we want to write new integration tests scenarios for dashboard we need to create ```dasboard_test.dart``` file within root ( ```/integration_test``` ) directory and appropriate ```/dashboard``` directory which will contains all helper methods for main ```dashboard_test.dart``` file.

It is good approach that main test files have their helper files in order to avoid writing the same scenarious. Good example for that is test for login. Very likely all other tests for example test for VOD will require login to successfully run all other VOD tests. This is how we come to the situation to create a function that will perform the login action and which we will place in the login helper ( ```/login``` ) directory.

#### These are the steps to successfully run the tests ( locally ):
* Make sure that you have the latest changes on the master or develop branch.
* Make sure that you have flutter SDK installed on your system. You can check it by running command in your terminal ```flutter doctor -v```.
* Make sure that you have successfuly clean current application directory and run command for get all dependencies by command ```flutter clean && flutter pub get```.
* Make sure that you have at least one emulator installed on your system ( Android and iOS ).
* Run the emulator with command ```flutter emulators --launch <emulator id>```. To get all available emulators run command ```flutter emulator``` to get emulator id.
* When choosed emulator will be ready you can finally run all test defined in ```index_test.dart``` file by command ```flutter test integration_test/index_test.dart```.

#### Advance usage:
* You can also run test seperatly by command ```flutter test integration_test/test_name_test.dart```.
* Order of test execution is defined in ```index_test.dart``` file.

## Setup Flutter native splash screen
Edit flutter_native_splash.yaml file and modify 'background_image' and 'image' properties the run the following:
 * flutter pub run flutter_native_splash:create --path=./flutter_native_splash.yaml

## Responsive UI

### Overview
A third party library is used to develop responsive user interface.

Below is a link to library:
* [Responsive Framework](https://pub.dev/packages/responsive_framework)

And here is API documentation of usage:
* [Responsive Framework API](https://pub.dev/documentation/responsive_framework/latest/)

On the home page of the library is a fairly simple explanation of how to use the tool itself so it is unnecessary to do some additional examples.
However, if there is a problem with using the library there is a very good video tutorial with a simple example so it is advisable to watch it before using.
* [Responsive Framework Video Tutorial](https://resocoder.com/2021/10/03/create-responsive-flutter-apps-with-minimal-effort/)

### Breakpoints
Breakpoints which are used in application are defined within *lib/src/theme/style.dart* file.