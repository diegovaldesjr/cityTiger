/* @ngInject */
function realizadosController(tigre, realizadosAPI, $cookies, loginFactory){
	"ngInject";

	var $ctrl = this;

	$ctrl.username = $cookies.username;

	$ctrl.trabajos = [];

	$ctrl.evaluacion = {
		trato: 0,
		responsabilidad: 0,
		trabajo: 0
	};

	$ctrl.calificar = false;
	$ctrl.verTrabajos = true;

	$ctrl.trabajo = {};

	$ctrl.cargarTrabajos = function(){
		realizadosAPI.getTrabajos($ctrl.username).then(function(response){
			var trabajos = response.data;

			trabajos.forEach(function(item, index){
				item['calificacion'] = (item.resp_t+item.trato_t+item.calidad_t)/3;

				realizadosAPI.verificarCalificado(item.id).then(function(responseCalificado){
					var calificado = responseCalificado.data;

					if(calificado.length)
						item['calificado'] = true;
					else
						item['calificado'] = false;		
				});
			});

			$ctrl.trabajos = trabajos;
			console.log($ctrl.trabajos);
		});
	};

	$ctrl.calificarEmpleador = function(){
		$ctrl.evaluacion.trabajo = $ctrl.trabajo.id;

		realizadosAPI.calificarEmpleador($ctrl.evaluacion).then(function(response){
			$ctrl.cargarTrabajos();
			$ctrl.calificar = false;
			$ctrl.verTrabajos = true;
			// $ctrl.promedio();
		});	
	};

	// $ctrl.promedio = function(){
	// 	tigre.getReptrabajador($ctrl.username).then(function(response){
			
	// 	});	
	// };

	$ctrl.perfil = function(username){
		loginFactory.perfil(username);
	};

	$ctrl.$onInit = function(){
		$ctrl.cargarTrabajos();
	};
}

angular.module('app')
	.component('realizados', {
		templateUrl: './app/realizados/realizados.html',
		controller: realizadosController
	});