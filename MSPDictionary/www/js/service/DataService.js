/**
 * Created by msp on 2016/10/21.
 */
var serviceModule = angular.module('dicApp.service');
serviceModule.factory("DataSvc",DataSvc);

DataSvc.$injector = ['$q','AppInfoSvc'];

function DataSvc($q,AppInfoSvc) {
    return{
        parseJson:parseJson,
        getAllData:getAllData,

    };

    function parseJson(jsonData) {
        var exec = cordova.require('cordova/exec');
        exec(null,null,"DataPlugin","parseData",[jsonData]);
    }


    function getAllData() {
        var defer = $q.defer();

        if(AppInfoSvc.isBrowser){
            console.log('browser platform');
        }else {
            var exec = cordova.require('cordova/exec');
            exec(function(data){
                defer.resolve(data);
            },function(error){
                console.log('getAllData error'+ ' '+error);
            },"DataPlugin","getAllData",[]);
        }

        return defer.promise;
    }
};