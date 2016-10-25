angular.module('dicApp').controller('HelpController', HelpController);

HelpController.inject = [
    '$rootScope',
    '$scope',
];

function HelpController($rootScope,$state,$scope) {
 $rootScope.hideTabs = true;

    $scope.$on('$destroy',function(){
        $rootScope.hideTabs = false;
    });
}
