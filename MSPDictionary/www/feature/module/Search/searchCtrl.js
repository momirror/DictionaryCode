angular.module('dicApp').controller('SearchController', SearchController);

SearchController.inject = [
    '$rootScope',
    '$scope',
    '$http',
    'DataSvc',
    'AppInfoSvc'

];
function SearchController($rootScope, $scope, $http,DataSvc,AppInfoSvc) {

    var vm = this;
    console.log(AppInfoSvc.platform());

    vm.clearInput = function () {
        vm.searchText = "";
        vm.bClear = false;
        vm.hasResult = false;
    };

    vm.searchWord = function () {

        var word = vm.searchText;
        if (word == undefined) {
            vm.NoInput = true;

            return;
        }
        else {
            vm.showProgress = true;
            vm.NoInput = false;
            vm.hasResult = false;

        }

        var url = "http://fanyi.youdao.com/openapi.do?keyfrom=momirror&key=357484575&type=data&doctype=json&version=1.1&q=" + word;
        $http.get(url)
            .success(function (response) {

                vm.showProgress = false;
                DataSvc.parseJson(response);

                
                var basic = response.basic;
                vm.hasResult = (basic != undefined);
                vm.bSearchFail = true;
                     
                if(basic != undefined)
                {
                    vm.bSearchFail = false;
                    //             vm.usphonetic = basic.us-phonetic;
//             vm.ukphonetic = basic.uk-phonetic;
                    vm.usphonetic = basic.phonetic;
                    vm.ukphonetic = basic.phonetic;
                    vm.searchResult = basic.explains;


                    DataSvc.getAllData().then(function (data) {
                        var wordDatas = data;


                        $rootScope.words = data;
                    });

                };
            })
            .error(function (e) {
                alert('请求失败了');
                vm.showProgress = false;
            });

    }


    $scope.$watch("vm.searchText",function(newValue){
               
        vm.bClear = (newValue != undefined && newValue != "");
                
    });
};


