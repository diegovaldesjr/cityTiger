/* @ngInject */
function dashboardController(dashboardAPI, $cookies, $cookieStore, $location){
	"ngInject";

	var $ctrl = this;

	$ctrl.$onInit = function(){
		// $ctrl.cargarCiudades();
	};
}

angular.module('app')
	.component('dashboard', {
		templateUrl: './app/dashboard/dashboard.html',
		controller: dashboardController
	});