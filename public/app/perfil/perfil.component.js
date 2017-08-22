/* @ngInject */
function perfilController(miperfilAPI, explorarAPI, $cookies, loginFactory){
	"ngInject";

	var $ctrl = this;

	$ctrl.informacion = false;
	$ctrl.verCreados =false;
	$ctrl.verHechos = false;

	$ctrl.perfil = {
		username: $cookies.usuario,
		nombre: "",
		apellido: "",
		email: "",
		telefono: "",
		estado: "",
		ciudad: "",
		zona: "",
		reputacion_empleador: 0,
		reputacion_trabajador: 0
	};

	$ctrl.trabajosHechos = [];
	$ctrl.trabajosCreados = [];

	$ctrl.categorias = [];
	$ctrl.subcategorias = [];


	$ctrl.cargarUsuario = function(){
		miperfilAPI.getUsuario($ctrl.perfil.username).then(function(response){
			var informacion = response.data;

			$ctrl.perfil.nombre = informacion[0].nombre;
			$ctrl.perfil.apellido = informacion[0].apellido;
			$ctrl.perfil.email = informacion[0].email;
			$ctrl.perfil.telefono = informacion[0].telefono;
			$ctrl.perfil.estado = informacion[0].estado;
			$ctrl.perfil.ciudad = informacion[0].ciudad;
			$ctrl.perfil.zona = informacion[0].zona;
			$ctrl.perfil.reputacion_trabajador = informacion[0].reputacion_trabajador;
			$ctrl.perfil.reputacion_empleador = informacion[0].reputacion_empleador;
		});
	};

	$ctrl.cargarmisCategorias = function(){
		miperfilAPI.getCategorias($ctrl.perfil.username).then(function(response){
			$ctrl.categorias = response.data;
		});
	};

	$ctrl.cargarmisSubcategorias = function(){
		explorarAPI.getHabilidades($ctrl.perfil.username).then(function(response){
			$ctrl.subcategorias = response.data;
		});
	};

	$ctrl.perfil = function(username){
		loginFactory.perfil(username);
	}

	$ctrl.$onInit = function(){
		$ctrl.cargarUsuario();
		$ctrl.cargarmisCategorias();
		$ctrl.cargarmisSubcategorias();
		console.log($cookies.usuario);
	};
}

angular.module('app')
	.component('perfil', {
		templateUrl: './app/perfil/perfil.html',
		controller: perfilController
	});