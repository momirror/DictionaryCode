angular.module('dicApp').controller('setController', setController);

setController.inject = [
    '$rootScope',
    '$scope',
    'currentData',
];

function setController($rootScope,$state,$scope,currentData) {

    $scope.items = currentData;
}
