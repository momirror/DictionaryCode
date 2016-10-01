/**
 * Created by msp on 2016/3/21.
 */

angular.module('dicApp').controller('ListController', ListController);

ListController.inject = [
    '$rootScope',
    '$scope',
    'getAllWord',
];

function ListController($scope,$rootScope,getAllWord) {

    var vm = this;
    getAllWord.getAllData().then(function(data){
//                                 alert(data);
       $rootScope.words = data;
    });
};