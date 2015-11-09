module.exports = {

    // --- initialization objects -----------------//

    initialize: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "start");
    },

    // --- refresh speaker information objects ----//

    startRefreshDeviceInfo: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "startRefreshDeviceInfo");
    },
    stopRefreshDeviceInfo: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "stopRefreshDeviceInfo");
    },
    refreshDeviceInfoOnce: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "refreshDeviceInfoOnce");
    },

    // --- playback control objects ---------------//

    playCAF: function(successCallback, errorCallback, urlString, songName, resumeFlag) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "playCAF", [urlString, songName, resumeFlag]);
    },
    pause: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "pause");
    },
    stop: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "stop");
    },
    isPlaying: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "isPlaying");
    },
    playCAFFromCertainTime: function(successCallback, errorCallback, urlString, songName, startTime) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "playCAFFromCertainTime", [urlString, songName, startTime]);
    },
    playWAV: function(successCallback, errorCallback, soundFilePath) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "playWAV", [soundFilePath]);
    },
    playStreamingMedia: function(successCallback, errorCallback, streamingMediaUrl) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "playStreamingMedia", [streamingMediaUrl]);
    },
    getPlayerState: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getPlayerState");
    },


    // --- volume control objects -----------------//

    setVolume: function(successCallback, errorCallback, volume) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "setVolume", [volume]);
    },
    mute: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "mute");
    },
    setVolumeDevice: function(successCallback, errorCallback, deviceId, volume) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "setVolumeDevice", [deviceId, volume]);
    },
    getVolume: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getVolume");
    },
    getDeviceVolume: function(successCallback, errorCallback, deviceId) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceVolume", [deviceId]);
    },
    getMaximumVolumeLevel: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getMaximumVolumeLevel");
    },
    unmute: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "unmute");
    },
    isMuted: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "isMuted");
    },


    // --- device (speaker) management objects ----//

    addDeviceToSession: function(successCallback, errorCallback, deviceId) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "addDeviceToSession", [deviceId]);
    },
    removeDeviceFromSession: function(successCallback, errorCallback, deviceId) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "removeDeviceFromSession", [deviceId]);
    },
    getDeviceCount: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceCount");
    },
    getGroupCount: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getGroupCount");
    },
    getActiveDeviceCount: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getActiveDeviceCount");
    },

    // --- note to self --- double check the following device management objects ----//
    getDeviceCountInGroupIndex: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceCountInGroupIndex");
    },
    getDeviceInfoByGroupIndexAndDeviceIndex: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceInfoByGroupIndexAndDeviceIndex");
    },
    getDeviceInfoByIndex: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceInfoByIndex");
    },
    getDeviceGroupByDeviceId: function(successCallback, errorCallback, deviceId) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceGroupByDeviceId", [deviceId]);
    },
    getDeviceInfoById: function(successCallback, errorCallback, deviceId) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceInfoById", [deviceId]);
    },
    isDeviceAvailable: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "isDeviceAvailable");
    },
    isDeviceActive: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio" ,"isDeviceActive");
    },
    removeDeviceFromGroup: function(successCallback, errorCallback, deviceId) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "removeDeviceFromGroup", [deviceId]);
    },
    getDeviceGroupByIndex: function(successCallback, errorCallback, groupIndex) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceGroupByIndex", [groupIndex]);
    },
    getDeviceGroupByGroupId: function(successCallback, errorCallback, groupId) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceGroupByGroupId", [groupId]);
    },
    getDeviceGroupNameByIndex: function(successCallback, errorCallback, groupIndex) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceGroupNameByIndex", [groupIndex]);
    },
    getDeviceGroupIdByIndex: function(successCallback, errorCallback, groupIndex) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getDeviceGroupIdByIndex", [groupIndex]);
    },
    setDeviceName: function(successCallback, errorCallback, deviceId, deviceName) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "setDeviceName", [deviceId, deviceName]);
    },
    setDeviceGroupName: function(successCallback, errorCallback, deviceId) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "setDeviceGroupName", [deviceId, groupName]);
    },
    setDeviceRole: function(successCallback, errorCallback, deviceId, role) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "setDeviceRole", [deviceId, role]);
    },
    getActiveGroupCount: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getActiveGroupCount");
    },
    refreshDeviceWiFiSignal: function(successCallback, errorCallback, deviceId) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "refreshDeviceWiFiSignal", [deviceId]);
    },
    getWifiSignalStrengthType: function(successCallback, errorCallback, wifiSignal) {
        cordova.exec(successCallback, errorCallback, "HKAudio", "getWifiSignalStrengthType", [wifiSignal]);
    }

};
