angular.module('app')
	.service('creadosAPI', ['$http', function ($http){

		function getTrabajos(username){
			var serverUrl = '/users/trabajos/username/'+username;
			return $http.get(serverUrl);
		}

		function eliminarTrabajo(id){
			var serverUrl = '/users/trabajos/eliminar/'+id;
			return $http.get(serverUrl);
		}

		function getPostulados(id){
			var serverUrl = '/users/trabajos/postulados/'+id;
			return $http.get(serverUrl);
		}

		function editarTrabajo(data){
			var serverUrl = '/users/trabajos/editar';
			return $http.post(serverUrl, data);
		}

		function savePostulado(data){
			var serverUrl = '/users/trabajos/postulado';
			return $http.post(serverUrl, data);
		}

		function verificarPostulado(id){
			var serverUrl = '/users/trabajos/postulados/verificar/'+id;
			return $http.get(serverUrl);
		}		

		function calificarTrabajador(data){
			var serverUrl = '/users/trabajos/calificar/trabajador';
			return $http.post(serverUrl, data);
		}

		function verificarCalificado(id){
			var serverUrl = '/users/trabajos/calificar/verificar/trabajador/'+id;
			return $http.get(serverUrl);
		}

		this.verificarCalificado = verificarCalificado;
		this.calificarTrabajador = calificarTrabajador;
		this.verificarPostulado = verificarPostulado;
		this.savePostulado = savePostulado;
		this.getPostulados = getPostulados;
		this.editarTrabajo = editarTrabajo;
		this.eliminarTrabajo = eliminarTrabajo;
		this.getTrabajos = getTrabajos;

	}]);