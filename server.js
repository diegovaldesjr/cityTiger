var express = require('express');
var app = express();
var morgan = require('morgan');             // log requests to the console (express4)
var bodyParser = require('body-parser');    // pull information from HTML POST (express4)
var methodOverride = require('method-override'); // simulate DELETE and PUT (express4)
var mysql = require('mysql');

//Configuracion
app.use(express.static(__dirname + '/public/dist'));                 // set the static files location /public/img will be /img for users
app.use(morgan('dev'));                                         // log every request to the console
app.use(bodyParser.urlencoded({'extended':'true'}));            // parse application/x-www-form-urlencoded
app.use(bodyParser.json());                                     // parse application/json
app.use(bodyParser.json({ type: 'application/vnd.api+json' })); // parse application/vnd.api+json as json
app.use(methodOverride());

//Manejo de rutas
var admin = require('./routes/admin');
var users = require('./routes/users');

app.use('/admin', admin);
app.use('/users', users);

//catch 404 and forward to error handler
// app.use(function(req, res, next){
// 	var err = new Error('Not found');
// 	err.status = 404;

// });

app.get('/', function(req, res) {
    res.sendfile('./dist/index.html');
});

app.listen(8080, function(err){
	if(err){
		return console.log('Hubo un error al conectar'), process.exit(1);
	}
	return console.log('Se conecto en el puerto 8080');
});