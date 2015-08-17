cordova.define("com.brainrainsolutions.hkaudio.hkaudio", function(require, exports, module) { /*global cordova, module*/


    module.exports = {
        initialize: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "start");
        },
        startRefreshDeviceInfo: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "startRefreshDeviceInfo");
        },
        stopRefreshDeviceInfo: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "stopRefreshDeviceInfo");
        },
        getGroupCount: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "getGroupCount");
        },
        getActiveDeviceCount: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "getActiveDeviceCount");
        },
         removeDeviceFromSession: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "removeDeviceFromSession");
        },
         addDeviceToSession: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "addDeviceToSession");
        },
        getDeviceCount: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceCount");
        },
        isPlaying: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "isPlaying");
        },
        /*
        * urlString
        * songName
        * resumeFlag
         */
        playCAF: function (successCallback, errorCallback, urlString, songName, resumeFlag) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "playCAF", [urlString, songName, resumeFlag]);
        },
        stop: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "stop");
        },
        pause: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "pause");
        },
         setVolume: function (successCallback, errorCallback, volume) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "setVolume", [volume]);
        },
        mute: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "mute");
        }

    };
});

