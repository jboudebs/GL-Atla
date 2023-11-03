const express = require('express');
const router = express.Router();

router.get('/', (req, res) =>
{
  res.send('Hello World!');
});


router.all('*', (req, res) =>
{
    res.status(404).send({msg:'Page not found'});
});


module.exports = router;


