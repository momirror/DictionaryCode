
/**
 * Created by msp on 2016/3/21.
 */
var myApp = angular.module("dicApp");
myApp.config(function($stateProvider,$urlRouterProvider) {

    $urlRouterProvider.when("","/home/search");

    $stateProvider
        .state("search",{
            parent:'home',
            url:"/search",
            views: {
                'search-tab': {
                    templateUrl: "feature/module/search/search.html",
                    controller:'SearchController as vm',

                }
            }
        });
});

