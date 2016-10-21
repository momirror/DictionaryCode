/**
 * Created by msp on 2016/3/21.
 */

angular.module('dicApp').controller('ListController', ListController);

ListController.inject = [
    '$rootScope',
    '$scope',
    'DataSvc',
];

function ListController($scope,$rootScope,DataSvc) {

    var vm = this;
    DataSvc.getAllData().then(function(data){
//                                 alert(data);
       $rootScope.words = data;
    });
};