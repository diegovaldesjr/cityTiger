var express = require('express');
var router = express.Router();

router.get('/', function(req, res) {
	res.send('admin la loca');
});

module.exports = router;