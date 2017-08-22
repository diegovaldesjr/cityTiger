angular.module('app')
	.service('registrarAPI', ['$http', function ($http){

		function verificarUsername(username){
			var serverUrl = '/users/username/'+username;
			return $http.get(serverUrl);
		}

		function verificarEmail(email){
			var serverUrl = '/users/email/'+email;
			return $http.get(serverUrl);
		}

		function saveUsuario(data){
			var serverUrl = '/users/registrar';
			return $http.post(serverUrl, data);
		}		

		this.saveUsuario = saveUsuario;
		this.verificarUsername = verificarUsername;
		this.verificarEmail = verificarEmail;
		
	}]);