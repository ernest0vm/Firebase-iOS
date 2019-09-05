# Firebase-iOS
**iOS Native app connected to a Realtime Database (NoSQL) in Firebase service**

## Steps to config Firebase

- Create a new project in **https://console.firebase.google.com**
- name new firebase project
- add your app (iOS)
- add the app package name 
```
    com.ernestovaldez.KeyboardShortcuts
```
- add friendly app name (optional)
- click on **Register App**
- download file **GoogleService-Info.plist**

## Create a RealTime database

- Go to in **develop** > **database**
- create a new realtime database and name it.
- set in the rules (without authentication)
```
    {
        "rules": {
            ".read": true,
            ".write": true
        }
    }
```
- or set in the rules (with authentication)
```
    {
        "rules": {
            ".read": true,
            ".write": "auth !== null"
        }
    }
```
- change **null** value by **root**

## Create a Cloud Storage

- Go to in **develop** > **storage**
- create new storage
- define data center (if not defined previously)
- set in the rules
```
    rules_version = '2';
    service firebase.storage {
        match /b/{bucket}/o {
             match /{allPaths=**} {
                allow read, write;
            }
        }
    }
```
- create a new folder named **images**

## Email and Google Authentication

- Go to in **develop** > **authentication** > **Sing-in Method**
- Enable **Email/Password** and **Google**


## In the iOS app project

- copy the downloaded file to <root-project>/GoogleService-Info.plist
- run a **terminal** and init **CocoaPods** (Used by Google services)
- open your Pod File and add
```
  # add the Firebase pods
  pod 'Firebase/Analytics'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'Firebase/Auth'
  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods
```
- save the pod file
- then run the command
```
  pod install  
```
- open the **xcworkspace**
- run the project
- add new shortcut and save it.
- verify in Firebase console that the shortcut was added in the realtime database
  
## Dependencies

**CocoaPods**
```
pod 'Firebase/Analytics'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'Firebase/Auth'
```
  
## References

**Firebase**
- https://firebase.google.com/docs/ios/setup
- https://github.com/firebase/quickstart-ios
