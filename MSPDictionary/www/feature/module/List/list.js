/**
 * Created by msp on 2016/3/22.
 */
var myApp = angular.module("dicApp");
myApp.config(function($stateProvider,$urlRouterProvider) {

    $stateProvider
        .state("list",{
            parent:'home',
            url:"/list",
            views: {
                'list-tab': {
                    templateUrl: "feature/module/list/list.html",
                    controller:'ListController as vm',
                }
            }
        });
})
    .service("getAllWord",function($q)
    {
        this.getAllData=function()
        {
            var defer = $q.defer();

            var exec = cordova.require('cordova/exec');
            exec(function(data){
                defer.resolve(data);
            },function(){
                alert("getAllData error");
            },"DataPlugin","getAllData",[]);

            return defer.promise;
        }
    });
