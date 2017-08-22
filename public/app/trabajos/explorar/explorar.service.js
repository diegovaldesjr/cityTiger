angular.module('app')
	.service('explorarAPI', ['$http', function ($http){

		function getSubcategorias(){
			var serverUrl = '/users/subcategorias';
			return $http.get(serverUrl);
		}

		function getHabilidades(username){
			var serverUrl = '/users/habilidades/'+username;
			return $http.get(serverUrl);
		}

		function getTrabajos(username, subcategoria){
			var serverUrl = '/users/trabajos/buscar/'+username+'/'+subcategoria;
			return $http.get(serverUrl);
		}

		function getPostulaciones(username){
			var serverUrl = '/users/postulacion/'+username;
			return $http.get(serverUrl);
		}

		function getDireccion(username){
			var serverUrl = '/users/direccion/'+username;
			return $http.get(serverUrl);
		}		

		function savePostulacion(data){
			var serverUrl = '/users/postular';
			return $http.post(serverUrl, data);
		}	

		this.getHabilidades = getHabilidades;
		this.getDireccion = getDireccion;
		this.getPostulaciones = getPostulaciones;
		this.savePostulacion = savePostulacion;
		this.getSubcategorias = getSubcategorias;
		this.getTrabajos = getTrabajos;

	}]);