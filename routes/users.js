var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var conector = require('../models/connect.js');

var con = conector.conectar();

router.get('/estados', function(req, res){
  con.query("SELECT DISTINCT estado FROM ubicacion", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

router.get('/ciudades/:estado', function(req, res){
  con.query("SELECT DISTINCT ciudad FROM ubicacion WHERE estado='"+req.params.estado+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

router.get('/zonas/:estado/:ciudad', function(req, res){
  con.query("SELECT zona FROM ubicacion WHERE estado='"+req.params.estado+"' AND ciudad='"+req.params.ciudad+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

router.get('/categorias', function(req, res){
  con.query("SELECT DISTINCT nombre FROM categoria", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

router.get('/subcategorias', function(req, res){
  con.query("SELECT DISTINCT * FROM subcategoria", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Busca subcategorias dominadas por el usuario
router.get('/habilidades/:username', function(req, res){
  con.query("SELECT DISTINCT subcategoria, categoria FROM especializado WHERE username='"+req.params.username+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

router.get('/categorias/:categoria', function(req, res){
  con.query("SELECT DISTINCT * FROM subcategoria WHERE categoria='"+req.params.categoria+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Busca trabajos hechos por un usuario
router.get('/trabajos/username/:username', function(req, res){
  con.query("SELECT * FROM trabajo WHERE id_empleador='"+req.params.username+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Busca trabajos por subcategoria
router.get('/trabajos/buscar/:username/:subcategoria', function(req, res){
  con.query("SELECT * FROM trabajo WHERE subcategoria='"+req.params.subcategoria+"' AND id_empleador!='"+req.params.username+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Verifica si ya se eligio postulante
router.get('/trabajos/postulados/verificar/:id', function(req, res){
  con.query("SELECT * FROM elige WHERE id_trabajo='"+req.params.id+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Eliminar trabajo
router.get('/trabajos/eliminar/:id', function(req, res){
  con.query("DELETE FROM trabajo WHERE id='"+req.params.id+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Busca postulaciones de un trabajo
router.get('/trabajos/postulados/:id', function(req, res){
  con.query("SELECT usuario.reputacion_trabajador, usuario.estado, usuario.ciudad, usuario.zona, postula.* FROM postula INNER JOIN usuario ON postula.id_trabajo='"+req.params.id+"' AND postula.id_trabajador=usuario.username", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Busca postulaciones de un usuario en especifico
router.get('/postulacion/:username', function(req, res){
  con.query("SELECT * FROM postula WHERE id_trabajador='"+req.params.username+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Buscar direccion del usuario
router.get('/direccion/:username', function(req, res){
  con.query("SELECT ciudad, estado, zona FROM usuario WHERE username='"+req.params.username+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Verificar si un username esta disponible
router.get('/username/:username', function(req, res){
  con.query("SELECT username FROM usuario WHERE username='"+req.params.username+"'", function (err, result, fields) {
    if (err) throw err;
    // console.log(result);
    if(!result.length)
      res.send(true);
    else
      res.send(false);
  });
});

//Verificar si un correo ya esta registrado
router.get('/email/:email', function(req, res){
  con.query("SELECT email FROM usuario WHERE email='"+req.params.email+"'", function (err, result, fields) {
    if (err) throw err;
    // console.log(result);
    if(!result.length)
      res.send(false);
    else
      res.send(true);
  });
});

router.post('/registrar', function(req, res){
  var data = {
    username: req.body.username,
    email: req.body.email,
    nombre: req.body.nombre,
    apellido: req.body.apellido,
    contrasena: req.body.contrasena,
    telefono: req.body.telefono,
    estado: req.body.estado,
    ciudad: req.body.ciudad,
    zona: req.body.zona
  };
  con.query("INSERT INTO usuario (username, nombre, apellido, reputacion_empleador, reputacion_trabajador, email, telefono, contrasena, estado, ciudad, zona) VALUES ('"+data.username+"', '"+data.nombre+"', '"+data.apellido+"', 0, 0, '"+data.email+"', '"+data.telefono+"', '"+data.contrasena+"', '"+data.estado+"', '"+data.ciudad+"', '"+data.zona+"')", function (err, result) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

router.get('/login/:username/:contrasena', function(req,res){
  con.query("SELECT username, nombre, apellido FROM usuario WHERE username='"+req.params.username+"' AND contrasena='"+req.params.contrasena+"'",function(err,result,fields){
    if(err) throw err;
    // console.log(result);
    res.send(result);
  });
});

router.post('/trabajos/crear', function(req, res){
  var data = {
    username: req.body.username,
    nombre: req.body.nombre,
    descripcion: req.body.descripcion,
    categoria: req.body.categoria,
    subcategoria: req.body.subcategoria,
    presupuesto: req.body.presupuesto,
    estado: req.body.estado,
    ciudad: req.body.ciudad,
    zona: req.body.zona
  };
  con.query("INSERT INTO trabajo (`id_empleador`, `nombre`, `descripcion`, `presupuesto`, `fecha_creado`, `ciudad`, `estado`, `zona`, `categoria`, `subcategoria`) VALUES ('"+data.username+"','"+data.nombre+"','"+data.descripcion+"','"+data.presupuesto+"',now(),'"+data.estado+"','"+data.ciudad+"','"+data.zona+"','"+data.categoria+"','"+data.subcategoria+"')", function (err, result) {
    if (err) throw err;
    // console.log(result);
    res.send(result);
  });
});

router.post('/postular', function(req, res){
  var data = {
    username: req.body.username,
    trabajo: req.body.trabajo,
    precio: req.body.precio,
    descripcion: req.body.descripcion
  };
  con.query("INSERT INTO postula (id_trabajo, id_trabajador, descripcion, precio) VALUES ('"+data.trabajo+"', '"+data.username+"', '"+data.descripcion+"', '"+data.precio+"')", function (err, result) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Editar trabajo
router.post('/trabajos/editar', function(req, res){
  var data = {
    id: req.body.id,
    nombre: req.body.nombre,
    descripcion: req.body.descripcion,
    categoria: req.body.categoria,
    subcategoria: req.body.subcategoria,
    presupuesto: req.body.presupuesto,
    estado: req.body.estado,
    ciudad: req.body.ciudad,
    zona: req.body.zona
  };
  con.query("UPDATE trabajo SET nombre='"+data.nombre+"', descripcion='"+data.descripcion+"', presupuesto="+data.presupuesto+", categoria='"+data.categoria+"', subcategoria='"+data.subcategoria+"', estado='"+data.estado+"', ciudad='"+data.ciudad+"', zona='"+data.zona+"' WHERE id="+data.id, function (err, result) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Elige postulado para un trabajo
router.post('/trabajos/postulado', function(req, res){
  var data = {
    id_trabajador: req.body.id_trabajador,
    id_trabajo: req.body.id_trabajo,
    id_empleador: req.body.id_empleador
  };
  con.query("INSERT INTO elige (id_trabajador, id_trabajo, id_empleador, resp_e, trato_e, resp_t, trato_t, calidad_t) VALUES ('"+data.id_trabajador+"','"+data.id_trabajo+"','"+data.id_empleador+"', 0, 0, 0, 0, 0)", function (err, result) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Busca informacion de un usuario
router.get('/usuario/:username', function(req, res){
  con.query("SELECT * FROM usuario WHERE username='"+req.params.username+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Busca categorias que domina un usuario
router.get('/usuario/categorias/:username', function(req, res){
  con.query("SELECT DISTINCT categoria FROM especializado WHERE username='"+req.params.username+"'", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Edita perfil de un usuario
router.post('/perfil/editar', function(req, res){
  var data = {
    username: req.body.username,
    nombre: req.body.nombre,
    apellido: req.body.apellido,
    telefono: req.body.telefono,
    estado: req.body.estado,
    ciudad: req.body.ciudad,
    zona: req.body.zona
  };
  con.query("UPDATE usuario SET nombre='"+data.nombre+"', apellido='"+data.apellido+"', telefono="+data.telefono+", estado='"+data.estado+"', ciudad='"+data.ciudad+"', zona='"+data.zona+"' WHERE username='"+data.username+"'", function (err, result) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

router.post('/habilidad/agregar', function(req, res){
  var data = {
    username: req.body.username,
    categoria: req.body.categoria,
    subcategoria: req.body.subcategoria
  };
  con.query("INSERT INTO especializado (username, categoria, subcategoria) VALUES ('"+data.username+"','"+data.categoria+"','"+data.subcategoria+"')", function (err, result) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

router.post('/habilidad/eliminar', function(req, res){
  var data = {
    username: req.body.username,
    categoria: req.body.categoria,
    subcategoria: req.body.subcategoria
  };
  con.query("DELETE FROM especializado WHERE username='"+data.username+"' AND categoria='"+data.categoria+"' AND subcategoria='"+data.subcategoria+"'", function (err, result) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Buscar postulaciones de un usuario
router.get('/usuario/postulaciones/:username', function(req, res){
  con.query("SELECT trabajo.id, trabajo.nombre, postula.descripcion, postula.precio, trabajo.id_empleador FROM postula INNER JOIN trabajo ON postula.id_trabajador='"+req.params.username+"' AND postula.id_trabajo=trabajo.id", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Eliminar una postulacion
router.get('/usuario/postulaciones/eliminar/:username/:id', function(req, res){
  con.query("DELETE FROM postula WHERE id_trabajador='"+req.params.username+"' AND id_trabajo="+req.params.id, function (err, result) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Buscar trabajos hechos por un usuario
router.get('/usuario/realizados/:username', function(req, res){
  con.query("SELECT trabajo.id, trabajo.nombre, trabajo.descripcion, trabajo.id_empleador, elige.resp_t, elige.trato_t, elige.calidad_t FROM elige INNER JOIN trabajo ON elige.id_trabajador='"+req.params.username+"' AND elige.id_trabajo=trabajo.id", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Calificar empleado
router.post('/trabajos/calificar/trabajador', function(req, res){
  var data = {
    id: req.body.trabajo,
    trato: req.body.trato,
    resp: req.body.responsabilidad,
    calidad: req.body.calidad
  };
  con.query("UPDATE elige SET trato_t="+data.trato+", resp_t="+data.resp+", calidad_t="+data.calidad+" WHERE id_trabajo="+data.id, function (err, result) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Verificar si un trabajador fue calificado
router.get('/trabajos/calificar/verificar/trabajador/:id', function(req, res){
  con.query("SELECT * FROM elige WHERE id_trabajo="+req.params.id+" AND resp_t > 0 AND trato_t > 0 AND calidad_t > 0", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Calificar empleador
router.post('/trabajos/calificar/empleador', function(req, res){
  var data = {
    id: req.body.trabajo,
    trato: req.body.trato,
    resp: req.body.responsabilidad
  };
  con.query("UPDATE elige SET trato_e="+data.trato+", resp_e="+data.resp+" WHERE id_trabajo="+data.id, function (err, result) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Verificar si un empleador fue calificado
router.get('/trabajos/calificar/verificar/empleador/:id', function(req, res){
  con.query("SELECT * FROM elige WHERE id_trabajo="+req.params.id+" AND resp_e > 0 AND trato_e > 0", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Obtener reputacion trabajador
router.get('/usuario/reputacion/trabajador/:username', function(req, res){
  con.query("SELECT COUNT(elige.id_trabajador), usuario.reputacion_trabajador FROM usuario INNER JOIN elige ON elige.id_trabajador="+req.params.username+" AND elige.id_trabajador=usuario.username AND elige.resp_t > 0 AND elige.trato_t AND elige.calidad_t > 0", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

//Obtener reputacion empleador
router.get('/usuario/reputacion/empleador/:username', function(req, res){
  con.query("SELECT COUNT(elige.id_empleador), usuario.reputacion_empleador FROM usuario INNER JOIN elige ON elige.id_empleador="+req.params.username+" AND elige.id_empleador=usuario.username AND elige.resp_e > 0 AND elige.trato_e", function (err, result, fields) {
    if (err) throw err;
    console.log(result);
    res.send(result);
  });
});

// Carga una vista HTML simple donde irá nuestra Single App Page
// Angular Manejará el Frontend
// router.get('*', function(req, res) {
//   res.sendfile('./public/dist/index.html');
// });

module.exports = router;