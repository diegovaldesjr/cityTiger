angular.module('app')
	.service('postulacionesAPI', ['$http', function ($http){

		function getTrabajos(username){
			var serverUrl = '/users/usuario/postulaciones/'+username;
			return $http.get(serverUrl);
		}

		function eliminarPostulacion(username, id){
			var serverUrl = '/users/usuario/postulaciones/eliminar/'+username+'/'+id;
			return $http.get(serverUrl);
		}

		this.eliminarPostulacion = eliminarPostulacion;
		this.getTrabajos = getTrabajos;

	}]);