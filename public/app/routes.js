// Creación del módulo
var app = angular.module('app', ['ngRoute', 'ngCookies']);

//Configuración de las rutas
app.config(function($routeProvider) {

    $routeProvider
        .when('/', {
            title: 'Login',
            template: '<logeo></logeo>'
        })
        .when('/registrar', {
            title: 'Registrar',
            template: '<registrar></registrar>'
        })
        .when('/dashboard', {
            title: 'Dashboard',
            template: '<dashboard></dashboard>'
        })
        .when('/publicar', {
            title: 'Crear trabajos',
            template: '<publicar></publicar>'
        })
        .when('/explorar', {
            title: 'Explorar trabajos',
            template: '<explorar></explorar>'
        })
        .when('/creados', {
            title: 'Mis trabajos creados',
            template: '<creados></creados>'
        })
        .when('/habilidades', {
            title: 'Explorar trabajos con mis habilidades',
            template: '<habilidades></habilidades>'
        })
        .when('/realizados', {
            title: 'Mis trabajos realizados',
            template: '<realizados></realizados>'
        })
        .when('/postulaciones', {
            title: 'Mis postulaciones',
            template: '<postulaciones></postulaciones>'
        })
        .when('/miperfil', {
            title: 'Mi perfil',
            template: '<miperfil></miperfil>'
        })
        .when('/perfil', {
            title: 'Perfil',
            template: '<perfil></perfil>'
        })
        .when('/postulaciones', {
            title: 'Mis postulaciones',
            template: '<postulaciones></postulaciones>'
        })

        .otherwise({
            redirectTo: '/'
        });
});