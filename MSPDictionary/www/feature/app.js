var myApp = angular.module("dicApp",['ionic']);


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
//	.state("tabs.List",
//	{
//		url:"/list",
//		views: {
//        'list-tab': {
//          templateUrl: "list.html",
//          controller:function($rootScope,$scope){
//          	 $rootScope.nav_title="单词本";
//
//          }
//        }
//      }
//	})
//	 .state("tabs.wordDetail",{
//        url:"/wordDetail/:index",
//        views: {
//        'list-tab': {
//          templateUrl: "wordDetail.html",
//           controller:function($rootScope, $scope,$stateParams){
//    	$scope.wordIndex = $stateParams.index;
//    	$rootScope.nav_title=$scope.wordIndex;
//
//    },
//
//        }
//      },
//    })
//   .state("tabs.Set",{
//        url:"/set",
//
//        views: {
//        'set-tab': {
//          templateUrl: "set.html",
//           controller:'setController',
//            resolve:
//        {
//            currentData:setItems()
//        }
//        }
//      },
//
//
//    })
//    .state("tabs.setDetail",{
//        url:"/setDetail/:index",
//        resolve:{
//
//        	simpleObj:  function(){
////          return {value: 'simple!'};
//return "help.html";
//         }
//        },
//        views: {
//        'set-tab': {
////        templateUrl: "help.html",
//		 templateUrl: function ($stateParams){
//
//		 	if($stateParams.index == 0)
//		 	{
//		 		 return "sdf.html";
//		 	}
//		 	else
//		 	{
//		 		 return 'help.html';
//		 	}
//  },
//           controller:function($rootScope, $scope,$stateParams,simpleObj){
//    	$scope.index = $stateParams.index;
//    	//alert(simpleObj);
////  	alert($scope.nav_title);
//
//    }
//        }
//      },
//
//    });
//
//    function setItems()
//    {
//        return ['$q',function($q)
//        {
//            var dfd = $q.defer();
//
//            dfd.resolve(["导入生词","帮助"]);
//
//            return dfd.promise;
//
////          return ["导入生词","帮助"];
//        }]
//
//    };
//
    })

.service("parseData",function()
{
  this.parseJson=function(jsonData)
         {
            var exec = cordova.require('cordova/exec');
            exec(null,null,"DataPlugin","parseData",[jsonData]);
         }
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
                 alert("error");
                 },"DataPlugin","getAllData",[]);





         return defer.promise;
         }
})
;


//listController.inject = [
//    '$rootScope',
//    '$scope',
//    '$http',
//    'parseData',
//    'getAllWord'
//];
//
//function listController($scope,$rootScope,$http,parseData,getAllWord) {
//     alert("haha");
//         $scope.showProgress = "true";
//            $scope.NoInput = true;
//            getAllWord.getAllData().then(function(data){
//                                         var wordDatas = data;
//
//                                         $scope.words = data;
//                                         });
//
//
//
//	 $rootScope.nav_title="单词本";
//
//	 $scope.show="true";
//
//     $scope.clear=function()
//    {
//            alert("clear");
//        $scope.searchText="";
//    }
//
//	 $scope.searchWord=function(word)
//	 {
//        if(word == undefined)
//        {
//            $scope.NoInput = true;
//
//            return;
//        }
//        else
//        {
//            $scope.showProgress = true;
//            $scope.NoInput = false;
//
//        }
//
//	 	var url = "http://fanyi.youdao.com/openapi.do?keyfrom=momirror&key=357484575&type=data&doctype=json&version=1.1&q=" + word;
//	 	 $http.get(url)
//    .success(function(response) {
//
//             $scope.showProgress = false;
//             parseData.parseJson(response);
//
//             var basic = response.basic;
//
////             $scope.usphonetic = basic.us-phonetic;
////             $scope.ukphonetic = basic.uk-phonetic;
//             $scope.usphonetic = basic.phonetic;
//             $scope.ukphonetic = basic.phonetic;
//             $scope.searchResult = basic.explains;
//             $scope.hasResult = true;
//
//             getAllWord.getAllData().then(function(data){
//                                          var wordDatas = data;
//
//                                          $scope.words = data;
//                                          });
//
//
//             })
//    .error(function(e){
// alert('请求失败了');
// });
//	 };
//};
//.controller("helpController",function($scope,$state){
//
//}
//);