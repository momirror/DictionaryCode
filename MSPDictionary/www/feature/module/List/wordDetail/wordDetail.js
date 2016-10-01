/**
 * Created by msp on 2016/3/22.
 */
var myApp = angular.module("dicApp");
myApp.config(function($stateProvider,$urlRouterProvider) {

    //$urlRouterProvider.when("","/home/list");

    $stateProvider
        .state("list.wordDetail",{
            parent:'home',
            url:"/wordDetail/:index",
            views: {
                'list-tab': {
                    templateUrl: "feature/module/list/wordDetail/wordDetail.html",
                    controller:'WordDetailController as vm',

                }
            }
        });
});
