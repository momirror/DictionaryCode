/**
 * Created by msp on 2016/3/21.
 */
var myApp = angular.module("dicApp");
myApp.config(function($stateProvider,$urlRouterProvider) {

    //$urlRouterProvider.when("","/home/set");

    $stateProvider

        .state("set",{
            parent:'home',
            url:"/set",
            views: {
                'set-tab': {
                    templateUrl: "feature/module/set/set.html",
                    controller:'setController',
                    resolve:
                    {
                        currentData:setItems()
                    }
                }
            }
        });

    function setItems()
    {
        return ['$q',function($q)
        {
            //alert("setItems");
            var dfd = $q.defer();
            dfd.resolve(["导入生词","帮助"]);
            return dfd.promise;
        }]
    };
});
