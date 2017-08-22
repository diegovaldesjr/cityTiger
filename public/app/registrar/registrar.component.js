/* @ngInject */
function registrarController(tigre, registrarAPI, $location){
	"ngInject";

	var $ctrl = this;
	$ctrl.datos = {
		username: "",
		email: "",
		nombre: "",
		apellido: "",
		contrasena: "",
		telefono: "",
		estado: "",
		ciudad: "",
		zona: ""
	};

	$ctrl.estados = [];
	$ctrl.ciudades = [];
	$ctrl.zonas = [];

	$ctrl.usernameMessage = "";
	$ctrl.emailMessage = "";
	$ctrl.formMessage = "";

	$ctrl.validarUsername = function(username){
		$ctrl.usernameMessage = "";
		registrarAPI.verificarUsername(username).then(function(response){
			if(!response.data)
				$ctrl.usernameMessage = "Nombre de usuario existente";
		});
	};

	$ctrl.validarEmail = function(email){
		$ctrl.emailMessage = "";
		registrarAPI.verificarEmail(email).then(function(response){
			if(response.data)
				$ctrl.emailMessage = "Email invalido";
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

	$ctrl.registrarUsuario = function(){
		if($ctrl.datos.username == "" || $ctrl.datos.email == "" || $ctrl.datos.nombre == "" || $ctrl.datos.apellido == "" || $ctrl.datos.contrasena == "" || $ctrl.datos.telefono == "" || $ctrl.datos.estado == "" || $ctrl.datos.ciudad == "" || $ctrl.datos.zona == "")
			$ctrl.formMessage = "Ingrese todos los datos";
		else
		registrarAPI.saveUsuario($ctrl.datos).then(function(response){
			$location.path('/');
		});
	};

	$ctrl.$onInit = function(){
		$ctrl.cargarEstados();
	};
}

angular.module('app')
	.component('registrar', {
		templateUrl: './app/registrar/registrar.html',
		controller: registrarController
	});