/* @ngInject */
function navbarController(loginFactory, $cookies, $cookieStore){
	"ngInject";

	var $ctrl = this;

	$ctrl.nombre = $cookies.nombre;
	$ctrl.apellido = $cookies.apellido;

	$ctrl.logout = function(){
		loginFactory.logout();
	};

	// $ctrl.$onInit = function(){
		
	// };
}

angular.module('app')
	.component('tigreNavbar', {
		templateUrl: './app/navbar/navbar.html',
		controller: navbarController
	});