/*global cordova, module*/


    module.exports = {
        initialize: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "greet");
        },
        startRefreshDeviceInfo: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "startRefreshDeviceInfo");
        },
        stopRefreshDeviceInfo: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "stopRefreshDeviceInfo");
        },
        getGroupCount: function (successCallback, errorCallback) {
            cordova.exec(successCallback, errorCallback, "HKAudio", "getGroupCount");
        }

    };