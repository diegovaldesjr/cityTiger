angular.module('app')
	.service('tigre', ['$http', function ($http){

		function getEstados(){
			var serverUrl = '/users/estados';
			return $http.get(serverUrl);
		}

		function getCiudades(estado){
			var serverUrl = '/users/ciudades/'+estado;
			return $http.get(serverUrl);
		}

		function getZonas(estado, ciudad){
			var serverUrl = '/users/zonas/'+estado+"/"+ciudad;
			return $http.get(serverUrl);
		}

		function getCategorias(){
			var serverUrl = '/users/categorias';
			return $http.get(serverUrl);
		}

		function getSubcategorias(categoria){
			var serverUrl = '/users/categorias/'+categoria;
			return $http.get(serverUrl);
		}

		function getRepempleador(username){
			var serverUrl = '/users/usuario/reputacion/empleador/'+username;
			return $http.get(serverUrl);
		}

		function getReptrabajador(username){
			var serverUrl = '/users/usuario/reputacion/trabajador/'+username;
			return $http.get(serverUrl);
		}		

		this.getCategorias = getCategorias;
		this.getSubcategorias = getSubcategorias;
		this.getEstados = getEstados;
		this.getCiudades = getCiudades;
		this.getZonas = getZonas;

	}]);