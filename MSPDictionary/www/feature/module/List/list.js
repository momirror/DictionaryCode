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
});
