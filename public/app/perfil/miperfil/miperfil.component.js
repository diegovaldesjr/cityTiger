/* @ngInject */
function miperfilController(tigre, miperfilAPI, explorarAPI, $cookies, loginFactory){
	"ngInject";

	var $ctrl = this;

	$ctrl.editar = false;
	$ctrl.agregar =false;
	$ctrl.eliminar = false;

	$ctrl.perfil = {
		username: $cookies.username,
		nombre: $cookies.nombre,
		apellido: $cookies.apellido,
		email: "",
		telefono: "",
		estado: "",
		ciudad: "",
		zona: "",
		reputacion_empleador: 0,
		reputacion_trabajador: 0
	};

	$ctrl.datos = {
		username: $ctrl.perfil.username,
		nombre: $ctrl.perfil.nombre,
		apellido: $ctrl.perfil.apellido,
		telefono: "",
		estado: "",
		ciudad: "",
		zona: ""
	};

	$ctrl.misCategorias = [];
	$ctrl.misSubcategorias = [];
	$ctrl.newSubcategorias = [];

	$ctrl.categorias = [];
	$ctrl.subcategorias = [];

	$ctrl.estados = [];
	$ctrl.ciudades = [];
	$ctrl.zonas = [];

	$ctrl.formMessage = "";

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

	$ctrl.cargarUsuario = function(){
		miperfilAPI.getUsuario($ctrl.perfil.username).then(function(response){
			var informacion = response.data;

			$ctrl.perfil.email = informacion[0].email;
			$ctrl.perfil.telefono = $ctrl.datos.telefono = informacion[0].telefono;
			$ctrl.perfil.estado = $ctrl.datos.estado = informacion[0].estado;
			$ctrl.perfil.ciudad = $ctrl.datos.ciudad = informacion[0].ciudad;
			$ctrl.perfil.zona = $ctrl.datos.zona = informacion[0].zona;
			$ctrl.perfil.reputacion_trabajador = informacion[0].reputacion_trabajador;
			$ctrl.perfil.reputacion_empleador = informacion[0].reputacion_empleador;
		});
	};

	$ctrl.cargarmisCategorias = function(){
		miperfilAPI.getCategorias($ctrl.perfil.username).then(function(response){
			$ctrl.misCategorias = response.data;
		});
	};

	$ctrl.cargarmisSubcategorias = function(){
		explorarAPI.getHabilidades($ctrl.perfil.username).then(function(response){
			$ctrl.misSubcategorias = response.data;
		});
	};

	$ctrl.editarPerfil = function(){
		miperfilAPI.editarPerfil($ctrl.datos).then(function(response){
			$ctrl.perfil.nombre = $ctrl.datos.nombre;
			$ctrl.perfil.apellido = $ctrl.datos.apellido;
			loginFactory.update($ctrl.perfil.nombre, $ctrl.perfil.apellido);
			$ctrl.cargarUsuario();
		});	
	};

	$ctrl.addSubcategoria = function(subcategoria, opcion){
		var repetido = false;
		
		$ctrl.newSubcategorias.forEach(function(item, index){
			if(item.nombre == subcategoria.nombre)
				repetido = true;
		});

		$ctrl.misSubcategorias.forEach(function(item, index){
			if(item.subcategoria == subcategoria.nombre && opcion == "agregar")
				repetido = true;
		});
		if(!repetido)
			$ctrl.newSubcategorias.push(subcategoria);
		console.log($ctrl.newSubcategorias);
	};

	$ctrl.agregarSubcategoria = function(){
		var data = {
			username: $ctrl.perfil.username,
			categoria: "",
			subcategoria: ""
		};

		$ctrl.newSubcategorias.forEach(function(item, index){
			data.categoria = item.categoria;
			data.subcategoria = item.nombre;

			miperfilAPI.saveHabilidad(data).then(function(response){
				$ctrl.newSubcategorias = [];
				$ctrl.agregar = false;
				$ctrl.cargarmisCategorias();
				$ctrl.cargarmisSubcategorias();
			});
		});
	};

	$ctrl.eliminarSubcategoria = function(){
		var data = {
			username: $ctrl.perfil.username,
			categoria: "",
			subcategoria: ""
		};

		$ctrl.newSubcategorias.forEach(function(item, index){
			data.categoria = item.categoria;
			data.subcategoria = item.nombre;

			miperfilAPI.eliminarHabilidad(data).then(function(response){
				$ctrl.newSubcategorias = [];
				$ctrl.eliminar = false;
				$ctrl.cargarmisCategorias();
				$ctrl.cargarmisSubcategorias();
			});
		});
	};

	$ctrl.$onInit = function(){
		$ctrl.cargarUsuario();
		$ctrl.cargarmisCategorias();
		$ctrl.cargarmisSubcategorias();
	};
}

angular.module('app')
	.component('miperfil', {
		templateUrl: './app/perfil/miperfil/miperfil.html',
		controller: miperfilController
	});