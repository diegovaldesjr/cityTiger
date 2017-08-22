angular.module('app')
	.service('miperfilAPI', ['$http', function ($http){

		function getUsuario(username){
			var serverUrl = '/users/usuario/'+username;
			return $http.get(serverUrl);
		}

		function getCategorias(username){
			var serverUrl = '/users/usuario/categorias/'+username;
			return $http.get(serverUrl);
		}

		function editarPerfil(data){
			var serverUrl = '/users/perfil/editar';
			return $http.post(serverUrl, data);
		}

		function saveHabilidad(data){
			var serverUrl = '/users/habilidad/agregar';
			return $http.post(serverUrl, data);
		}

		function eliminarHabilidad(data){
			var serverUrl = '/users/habilidad/eliminar';
			return $http.post(serverUrl, data);
		}

		this.eliminarHabilidad = eliminarHabilidad;
		this.saveHabilidad = saveHabilidad;
		this.editarPerfil = editarPerfil;
		this.getCategorias = getCategorias;
		this.getUsuario = getUsuario;

	}]);