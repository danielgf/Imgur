# Imgur

Make sure you have the lastest version of the Xcode and the command line tools installed: 

```
xcode-select --install
```

This project uses Fastlane, Swift Pack Manager and Bitrise, make sure you have installed:

## Fastlane

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions on fastlane
## iOS
### ios development
```
bundle exec fastlane development
```
This lane will buid our app for development
### ios tests
```
bundle exec fastlane tests
```

This lane will run swiftlint to see the code design
### ios run_swiftlint
```
bundle exec fastlane runSwiftlint
```
SwiftLint

----

## Swift Pack Manager (SPM)
This project uses the SPM 

### URL
```
https://github.com/SDWebImage/SDWebImage
```
----

# Clone 
### With Https
```
https://github.com/danielgf/Imgur.git
```
### With SSH
```
git@github.com:danielgf/Imgur.git
```

----

# Configurations of the project 

• This project uses XCode 14.2, Swift 5.7.2 and used the iPhone 14 Pro to execute and test the app

---
