/* @ngInject */
function habilidadesController(tigre, explorarAPI, $cookies, loginFactory){
	"ngInject";

	var $ctrl = this;

	$ctrl.username = $cookies.username;

	$ctrl.subcategorias = [];
	$ctrl.trabajos = [];
	$ctrl.postulaciones = [];

	$ctrl.propuesta = {
		username: $cookies.username,
		trabajo: 0,
		precio : 0,
		descripcion: ""
	};

	$ctrl.postulaMessage = "";
	$ctrl.formMessage = "";

	$ctrl.cargarHabilidades = function(){
		explorarAPI.getHabilidades($ctrl.username).then(function(response){
			$ctrl.subcategorias = response.data;
			$ctrl.cargarTrabajos();
		});
	};

	$ctrl.cargarTrabajos = function(){
		$ctrl.subcategorias.forEach(function(item, index){
			explorarAPI.getTrabajos($ctrl.username, item.subcategoria).then(function(response){
				var trabajos = response.data;

				trabajos.forEach(function(itemTrabajo, index){
					itemTrabajo['mostrar'] = true;

					$ctrl.postulaciones.forEach(function(itemPostulacion, index){
						if(itemPostulacion.id_trabajo == itemTrabajo.id)
							itemTrabajo.mostrar = false;
					});

					$ctrl.trabajos.push(itemTrabajo);
				});			
			});
		});
		console.log($ctrl.trabajos);
	};

	$ctrl.postular = function(trabajo){
		$ctrl.propuesta.trabajo = trabajo;
		if($ctrl.propuesta.username == "" || $ctrl.propuesta.precio == "" || $ctrl.propuesta.descripcion == "")
			$ctrl.formMessage = "Ingrese todos los datos";
		else
			explorarAPI.savePostulacion($ctrl.propuesta).then(function(response){
				// $ctrl.postulaMessage = "Postulacion enviada";
				$ctrl.trabajos.forEach(function(item, index){
					if(item.id == trabajo)
						item.mostrar = false;
				});
			});
	};

	$ctrl.revisarPostulaciones = function(){
		explorarAPI.getPostulaciones($ctrl.propuesta.username).then(function(response){
			$ctrl.postulaciones = response.data;
		});	
	};

	$ctrl.perfil = function(username){
		loginFactory.perfil(username);
	};
	
	//Cercania, evaluacion y precio
	$ctrl.filtroCercania = function(){
		
	};

	$ctrl.filtroPrecio = function(){

	};

	$ctrl.$onInit = function(){
		$ctrl.revisarPostulaciones();
		$ctrl.cargarHabilidades();
	};
}

angular.module('app')
	.component('habilidades', {
		templateUrl: './app/trabajos/habilidades/habilidades.html',
		controller: habilidadesController
	});