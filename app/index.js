var express = require('express');
var session = require('express-session')

var app = express();

var sess = {
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true,
    cookie: {
        maxAge: 3600000
    }
}

if (app.get('env') === 'production') {
    app.set('trust proxy', 1) // trust first proxy
    sess.cookie.secure = true // serve secure cookies
}
app.use(session(sess));

app.use(express.static('./public'));

app.get('/sid', function(req, res, next) {
    // Increment "index" in session
    console.log(req.session);
    req.session.index = (req.session.index || 0) + 1;
    // View "session-index.ejs"
    res.send('SID:' + req.sessionID + ' index:' + req.session.index);
});

//Mqtt
var mqtt = require('mqtt')
//var m  = mqtt.connect('mqtt://192.168.33.1')
var m = mqtt.connect('mqtt://192.168.24.50')
//Socket.io
var server = require('http').createServer(app);
var io = require('socket.io')(server);
io.on('connection', function(client) {
    console.log('new client');
    client.on('SD', (data) => {
        
        if (data.id == "2") {
            m.publish('/nodemcu/N01/LED', data.value)
        }
    });
});
io
server.listen(3000, function() {
    console.log('node-app listening on port 3000 ...')
});

m.on('connect', function() {
    m.subscribe('/nodemcu/N01')
    m.publish('/nodemcu/N01/LED', '1')
})

m.on('message', function(topic, message) {
    // message is Buffer
    //console.log(topic, message.toString())
    if (topic == "/nodemcu/N01") {
        var t = message.toString().split(":");
        if (t[0] == "VA") {
            io.emit('VA', {
                id: t[1],
                value: t[2]
            });
        }
        if (t[0] == "DS") {
            io.emit('DS', {
                id: t[1],
                value: t[2]
            });
        }
    }

})
