/* @ngInject */
function loginController(loginAPI, loginFactory){
	"ngInject";

	var $ctrl = this;

	$ctrl.username = "";
	$ctrl.contrasena = "";

	$ctrl.message = "";

	$ctrl.login = function(){
		loginAPI.login($ctrl.username, $ctrl.contrasena).then(function(response){
			if(response.data.length){
				console.log(response.data);
				loginFactory.login(response.data[0].username, response.data[0].nombre, response.data[0].apellido);
			}else
				$ctrl.message = "Usuario o contraseña invalidos";
			
		});
	};

	// $ctrl.$onInit = function(){

	// };
}

angular.module('app')
	.component('logeo', {
		templateUrl: './app/login/login.html',
		controller: loginController
	});