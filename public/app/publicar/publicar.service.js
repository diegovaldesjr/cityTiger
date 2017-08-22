angular.module('app')
	.service('publicarAPI', ['$http', function ($http){

		function saveTrabajo(data){
			var serverUrl = '/users/trabajos/crear';
			return $http.post(serverUrl, data);
		}	

		this.saveTrabajo = saveTrabajo;

	}]);