angular.module('app')
	.service('loginAPI', ['$http', function ($http){

		function login(username, contrasena){
			var serverUrl = '/users/login/'+username+'/'+contrasena;
			return $http.get(serverUrl);
		}

		this.login = login;

	}]);

angular.module('app')
	.factory('loginFactory', function ($cookies, $cookieStore, $location){
		return {
			login: function(username, nombre, apellido){
				$cookies.username = username;
				$cookies.nombre = nombre;
				$cookies.apellido = apellido;
				$location.path('/explorar');
			},
			logout: function(){
				$cookieStore.remove("username");
				$cookieStore.remove("nombre");
				$cookieStore.remove("apellido");
				$location.path('/');	
			},
			update: function(nombre, apellido){
				$cookies.nombre = nombre;
				$cookies.apellido = apellido;
			},
			perfil: function(username){
				$cookies.usuario = username;
				$location.path('/perfil');
			}
		}
	});