/* @ngInject */
function homeController($scope, homeAPI){
	"ngInject";

	var $ctrl = this;
	$ctrl.ciudades = [];

	// $ctrl.cargarCiudades = function(){
	// 	homeAPI.getCiudades().then(function(response){
	// 		$ctrl.ciudades = response.data;
	// 	});
	// 	console.log("CIUDAD");
	// };

	$ctrl.$onInit = function(){
		// $ctrl.cargarCiudades();
	};
}

angular.module('app')
	.component('home', {
		templateUrl: './app/home/home.html',
		controller: homeController
	});