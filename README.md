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
This method initializes the HK Wireless HD SDK.
+ **success:** Callback function if the SDK is successfully initialized and ready for use
+ **error:** Callback function if there was an error trying to initialze the SDK

```javascript
hkaudio.startRefreshDeviceInfo(success, error);
```
This method starts to keep refreshing device info every two seconds. It continues until `hkaudio.stopRefreshDeviceInfo` method is called.
+ **success:** Callback function on successful 
+ **error:** Callback function 

```javascript
hkaudio.stopRefreshDeviceInfo(success, error);
```
This method stops refresing the device info started by `hkaudio.startRefreshDeviceInfo`.
+ **success:** Callback function
+ **error:** Callback function

```javascript
hkaudio.getGroupCount(success, error);
```
This method gets the total number of available groups of speakers on the network.
+ **success:** Callback function
+ **error:** Callback function

```javascript
hkaudio.getActiveDeviceCount(success, error);
```
This method gets the number of active speakers
+ **success:** Callback function
+ **error:** Callback function

```javascript
hkaudio.removeDeviceFromSession(success, error, deviceId);
```
This method removes a speaker from the current playback session. The removed speaker will stop playing audio.
+ **success:** Callback function
+ **error:** Callback function
+ **deviceId:** *Integer.* The ID of the device to remove

```javascript
hkaudio.addDeviceToSession(success, error, deviceId);
```
This method adds a speaker to the current playback session. The added speaker will start playing audio. This can be done during the audio playback.
+ **success:** Callback function
+ **error:** Callback function
+ **deviceId:** *Integer.* The ID of the device to remove

```javascript
hkaudio.getDeviceCount(success, error);
```
This method gets the number of all speakers in the HKWirelessHD network.

```javascript
hkaudio.isPlaying(success, error);
```
This method checks if the player is playing some audio or not.
+ **success:** Callback function
+ **error:** Callback function

```javascript
hkaudio.playCAF(success, error, URL, songName, resumeFlag);
```
This method plays a CAF audio file in local storage.
+ **success:** Callback function
+ **error:** Callback function
+ **URL:** String. 
+ **songName:** String.
+ **resumeFlag:** Boolean.

```javascript
hkaudio.stop(success, error);
```
This method stops the current playback.
+ **success:** Callback function
+ **error:** Callback function

```javascript
hkaudio.pause(success, error);
```
This method pauses the current playback.
+ **success:** Callback function
+ **error:** Callback function

```javascript
hkaudio.setVolume(success, error, volume);
```
This method sets a volume level to all speakers. The same volume level is set to all speakers. The range is 0 to 50.
+ **success:** Callback function
+ **error:** Callback function
+ **volume:** Integer

```javascript
hkaudio.mute(success, error);
```
This method mutes the current volume of all speakers.
+ **success:** Callback function
+ **error:** Callback function


## Notes to mention to HK
* We would like getting started docs and sample code for Objective-C along with Swift.
* For easy accessibility, a download SDK link could be in sidebar so that it shows on every page, not just homepage.
