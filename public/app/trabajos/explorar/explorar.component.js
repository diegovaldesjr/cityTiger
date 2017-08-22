/* @ngInject */
function explorarController(tigre, explorarAPI, $cookies, loginFactory){
	"ngInject";

	var $ctrl = this;

	$ctrl.username = $cookies.username;

	$ctrl.categorias = [];
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
	// $ctrl.postulaMessage = {Message: "", flag: false};
	$ctrl.formMessage = "";


	$ctrl.cargarCategorias = function(){
		tigre.getCategorias().then(function(response){
			$ctrl.categorias = response.data;

			$ctrl.categorias.forEach(function(item, index){
				item['mostrar'] = false;
			});
		});
	};

	$ctrl.cargarSubcategorias = function(){
		explorarAPI.getSubcategorias().then(function(response){
			$ctrl.subcategorias = response.data;
		});
	};

	$ctrl.cargarTrabajos = function(subcategoria){
		explorarAPI.getTrabajos($ctrl.username, subcategoria).then(function(response){
			var trabajos = response.data;

			trabajos.forEach(function(itemTrabajo, index){
				itemTrabajo['mostrar'] = true;

				$ctrl.postulaciones.forEach(function(itemPostulacion, index){
					if(itemPostulacion.id_trabajo == itemTrabajo.id)
						itemTrabajo.mostrar = false;
				});
			});

			$ctrl.trabajos = trabajos;			
		});	
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
		explorarAPI.getDireccion($ctrl.propuesta.username).then(function(response){
			$ctrl.trabajos = [];
			var trabajos = response.data;

			trabajos.forEach(function(item, index){
				
			});
		});
	};

	$ctrl.filtroPrecio = function(){

	};

	$ctrl.$onInit = function(){
		$ctrl.revisarPostulaciones();
		$ctrl.cargarCategorias();
		$ctrl.cargarSubcategorias();
	};
}

angular.module('app')
	.component('explorar', {
		templateUrl: './app/trabajos/explorar/explorar.html',
		controller: explorarController
	});