var myApp = angular.module("dicApp",['ionic','dicApp.service']);


myApp.config(function($stateProvider,$urlRouterProvider)
{
	$urlRouterProvider.when("","/tabs/search");
	
	$stateProvider
	.state("tabs",
	{
		url:"/tabs",
		templateUrl:"./feature/module/tabs/tabs.html",
	})
	.state("tabs.Search",
	{
		url:"/search",
		views: {
        'home-tab': {
          templateUrl: "./feature/module/Search/search.html",
          controller:"SearchController"
        }
      }
	})
});

//定义模块
angular.module('dicApp.service',[]);