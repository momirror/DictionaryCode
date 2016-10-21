/**
 * Created by msp on 16/10/16.
 */

var app = angular.module('dicApp.service',[]);
app.service('AppInfoSvc',function() {
    return {
        platform:getPlatform,
        isIOS:isIOS,
        isAndroid:isAndroid,
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
});


