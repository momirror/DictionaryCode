/**
 * Created by msp on 2016/3/21.
 */
var myApp = angular.module("dicApp");
myApp.config(function($stateProvider,$urlRouterProvider) {

    $stateProvider
        .state("set.help",{
            parent:"home",
        url:"/help/:index",
        views: {
        'set-tab': {
         templateUrl: function ($stateParams){

		 	if($stateParams.index == 0)
		 	{
		 		 return "sdf.html";
		 	}
		 	else
		 	{
		 		 return "feature/module/set/help/help.html";
		 	}
         },
            controller:"HelpController",

        }
        }

    });
});


