/**
 * Created by msp on 16/10/16.
 * get platform info
 */

var serviceModule = angular.module('dicApp.service');
serviceModule.service('AppInfoSvc',AppInfoSvc);
AppInfoSvc.$injector = ['$window'];
function AppInfoSvc($window) {
    return {
        platform:getPlatform,
        isIOS:isIOS,
        isAndroid:isAndroid,
        isBrowser:isBrowser,
    }

    function  getPlatform(){
        return navigator.platform;
    }

    function  isIOS(){
        return /iPad|iPhone|iPod/.test(navigator.platform);
    }

    function  isAndroid(){
        return  $window.ionic && $window.ionic.Platform.isAndroid();
    }

    function isBrowser(){
        return !isIOS() && !isAndroid();
    }
};


