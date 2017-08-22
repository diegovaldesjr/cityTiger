/* @ngInject */
function postulacionesController(postulacionesAPI, $cookies, loginFactory){
	"ngInject";

	var $ctrl = this;

	$ctrl.username = $cookies.username;

	$ctrl.trabajos = [];

	$ctrl.cargarTrabajos = function(){
		postulacionesAPI.getTrabajos($ctrl.username).then(function(response){
			$ctrl.trabajos = response.data;
		});
	};

	$ctrl.eliminarPostulacion = function(trabajo){
		postulacionesAPI.eliminarPostulacion($ctrl.username, trabajo).then(function(response){
			$ctrl.cargarTrabajos();
		});
	};

	$ctrl.perfil = function(username){
		loginFactory.perfil(username);
	};

	$ctrl.$onInit = function(){
		$ctrl.cargarTrabajos();
	};
}

angular.module('app')
	.component('postulaciones', {
		templateUrl: './app/postulaciones/postulaciones.html',
		controller: postulacionesController
	});