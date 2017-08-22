angular.module('app')
	.service('realizadosAPI', ['$http', function ($http){

		function getTrabajos(username){
			var serverUrl = '/users/usuario/realizados/'+username;
			return $http.get(serverUrl);
		}

		function calificarEmpleador(data){
			var serverUrl = '/users/trabajos/calificar/empleador';
			return $http.post(serverUrl, data);
		}

		function verificarCalificado(id){
			var serverUrl = '/users/trabajos/calificar/verificar/empleador/'+id;
			return $http.get(serverUrl);
		}

		this.calificarEmpleador =calificarEmpleador;
		this.verificarCalificado = verificarCalificado;
		this.getTrabajos = getTrabajos;

	}]);