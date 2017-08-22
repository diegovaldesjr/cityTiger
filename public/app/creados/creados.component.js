/* @ngInject */
function creadosController(tigre, creadosAPI, $cookies, loginFactory){
	"ngInject";

	var $ctrl = this;

	$ctrl.username = $cookies.username;
	$ctrl.trabajos = [];
	$ctrl.postulados = [];

	$ctrl.editar = false;
	$ctrl.verTrabajos = true;
	$ctrl.verPostulados = false;
	$ctrl.calificar = false;

	$ctrl.trabajo = {};
	$ctrl.postulado = {};

	$ctrl.estados = [];
	$ctrl.ciudades = [];
	$ctrl.zonas = [];

	$ctrl.categorias = [];
	$ctrl.subcategorias = [];

	$ctrl.formMessage = "";
	$ctrl.filtro="";

	$ctrl.evaluacion = {
		trato: 0,
		calidad: 0,
		responsabilidad: 0,
		trabajo: 0
	};

	$ctrl.cargarCategorias = function(){
		tigre.getCategorias().then(function(response){
			$ctrl.categorias = response.data;
		});
	};

	$ctrl.cargarSubcategorias = function(categoria){
		tigre.getSubcategorias(categoria).then(function(response){
			$ctrl.subcategorias = response.data;
		});
	};

	$ctrl.cargarEstados = function(){
		tigre.getEstados().then(function(response){
			$ctrl.estados = response.data;
		});
	};

	$ctrl.cargarCiudades = function(estado){
		tigre.getCiudades(estado).then(function(response){
			$ctrl.ciudades = response.data;
		});
	};

	$ctrl.cargarZonas = function(estado, ciudad){
		tigre.getZonas(estado, ciudad).then(function(response){
			$ctrl.zonas = response.data;
		});
	};

	$ctrl.cargarTrabajos = function(){
		creadosAPI.getTrabajos($ctrl.username).then(function(response){
			var trabajos = response.data;

			trabajos.forEach(function(item, index){
				creadosAPI.verificarPostulado(item.id).then(function(responsePostulado){
					var postulado = responsePostulado.data;

					if(postulado.length){
						item['postulado'] = true;
						creadosAPI.verificarCalificado(item.id).then(function(responseCalificado){
							var calificado = responseCalificado.data;

							if(calificado.length)
								item['calificado'] = true;
							else
								item['calificado'] = false;		
						});
					}
					else{
						item['postulado'] = false;
						item['calificado'] = false;
					}
				});
			});

			$ctrl.trabajos = trabajos;
			console.log($ctrl.trabajos);
		});
	};

	$ctrl.editarTrabajo = function(){
		if($ctrl.trabajo.nombre == "" || $ctrl.trabajo.descripcion == "" || $ctrl.trabajo.categoria == "" || $ctrl.trabajo.subcategoria == "" || $ctrl.trabajo.presupuesto == 0 || $ctrl.trabajo.estado == "" || $ctrl.trabajo.ciudad == "" || $ctrl.trabajo.zona == "")
			$ctrl.formMessage = "Ingrese todos los datos";
		else
			creadosAPI.editarTrabajo($ctrl.trabajo).then(function(response){
				$ctrl.editar = false;
				$ctrl.verTrabajos = true;
			});
	};

	$ctrl.eliminarTrabajo = function(trabajo){
		creadosAPI.eliminarTrabajo(trabajo).then(function(response){
			$ctrl.cargarTrabajos();
		});
	};

	$ctrl.cargarPostulados = function(trabajo){
		creadosAPI.getPostulados(trabajo).then(function(response){
			$ctrl.postulados = response.data;
		});
	};

	$ctrl.elegirPostulado = function(){
		var data = {
		    id_trabajador: $ctrl.postulado.id_trabajador,
		    id_trabajo: $ctrl.postulado.id_trabajo,
		    id_empleador: $ctrl.username
		  };
		creadosAPI.savePostulado(data).then(function(response){
			// $ctrl.postulados = response.data;
			$ctrl.cargarTrabajos();	
			$ctrl.verPostulados = false;
			$ctrl.verTrabajos = true;
		});
	};

	$ctrl.cargarPostulado = function(trabajo){
		creadosAPI.verificarPostulado(trabajo).then(function(response){
			
		});
	};

	$ctrl.calificarTrabajador = function(){
		$ctrl.evaluacion.trabajo = $ctrl.trabajo.id;

		creadosAPI.calificarTrabajador($ctrl.evaluacion).then(function(response){
			$ctrl.cargarTrabajos();
			$ctrl.calificar = false;
			$ctrl.verTrabajos = true;
			// $ctrl.promedio();
		});	
	};

	// $ctrl.promedio = function(){
	// 	tigre.getRepempleador($ctrl.username).then(function(response){
			
	// 	});	
	// };

	$ctrl.perfil = function(username){
		loginFactory.perfil(username);
	};

	$ctrl.$onInit = function(){
		$ctrl.cargarTrabajos();
		$ctrl.cargarCategorias();
		$ctrl.cargarEstados();
	};
}

angular.module('app')
	.component('creados', {
		templateUrl: './app/creados/creados.html',
		controller: creadosController
	});