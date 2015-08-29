HKAudio - A Harman Kardon Cordova Plugin
=========================================

HKAudio - A Harman Kardon Cordova plugin for Harman Kardon SDK


## Installation

This requires cordova 5.0+ ( current stable 1.0.0 )

     cordova plugin add https://github.com/JadisInteractive/harman-kardon-cordova

Change the deployment target in xcode to be 8.4. Otherwise you may get linking errors. 

## Remove Plugin
     cordova plugin rm com.jadisinteractive.hkaudio

## Usage
```javascript
hkaudio.initialize(success, error);
```
This initializes the HK Wireless HD SDK.
+ **success:** Callback function if the SDK is successfully initialized and ready for use
+ **error:** Callback function if there was an error trying to initialze the SDK

```javascript
hkaudio.startRefreshDeviceInfo(success, error);
```

```javascript
hkaudio.stopRefreshDeviceInfo(success, error);
```

```javascript
hkaudio.getGroupCount(success, error);
```

```javascript
hkaudio.getActiveDeviceCount(success, error);
```

```javascript
hkaudio.removeDeviceFromSession(success, error, deviceId);
```

```javascript
hkaudio.addDeviceToSession(success, error, deviceId);
```

```javascript
hkaudio.getDeviceCount(success, error);
```

```javascript
hkaudio.isPlaying(success, error);
```

```javascript
hkaudio.playCAF(success, error, URL, songName, resumeFlag);
```

```javascript
hkaudio.stop(success, error);
```

```javascript
hkaudio.pause(success, error);
```

```javascript
hkaudio.setVolume(success, error, volume);
```

```javascript
hkaudio.mute(success, error);
```


## Notes to mention to HK
* We would like getting started docs and sample code for objective c.
* For easy accessibility, a download SDK link could be in sidebar so that it shows on every page, not just homepage.
