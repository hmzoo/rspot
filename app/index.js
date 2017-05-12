var express = require('express')
var app = express()

app.get('/', function (req, res) {
  res.send('RSPOT APP HERE ...')
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
