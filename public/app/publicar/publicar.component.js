/* @ngInject */
function publicarController(tigre, publicarAPI, $cookies, $location){
	"ngInject";

	var $ctrl = this;

	$ctrl.trabajo = {
		username: $cookies.username,
		nombre: "",
		descripcion: "",
		categoria: "",
		subcategoria: "",
		presupuesto: "",
		estado: "",
		ciudad: "",
		zona: ""
	};

	$ctrl.estados = [];
	$ctrl.ciudades = [];
	$ctrl.zonas = [];

	$ctrl.categorias = [];
	$ctrl.subcategorias = [];

	$ctrl.formMessage = "";

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

	$ctrl.crearTrabajo = function(){
		if($ctrl.trabajo.nombre == "" || $ctrl.trabajo.descripcion == "" || $ctrl.trabajo.categoria == "" || $ctrl.trabajo.subcategoria == "" || $ctrl.trabajo.presupuesto == 0 || $ctrl.trabajo.estado == "" || $ctrl.trabajo.ciudad == "" || $ctrl.trabajo.zona == "")
			$ctrl.formMessage = "Ingrese todos los datos";
		else
		publicarAPI.saveTrabajo($ctrl.trabajo).then(function(response){
			$location.path('/dashboard');
		});
	};

	$ctrl.$onInit = function(){
		$ctrl.cargarEstados();
		$ctrl.cargarCategorias();
	};
}

angular.module('app')
	.component('publicar', {
		templateUrl: './app/publicar/publicar.html',
		controller: publicarController
	});