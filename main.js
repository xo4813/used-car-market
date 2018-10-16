var express = require('express');
var path = require('path');
var app = express();

app.use('/assets', express.static(__dirname + '/assets'));

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

app.get('/index.html', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

app.get('/features.html', (req, res) => {
    res.sendFile(__dirname + '/features.html');
});

app.get('/pricing.html', (req, res) => {
    res.sendFile(__dirname + '/pricing.html');
});

app.get('/about-us.html', (req, res) => {
    res.sendFile(__dirname + '/about-us.html');
});

app.get('/contact-us.html', (req, res) => {
    res.sendFile(__dirname + '/contact-us.html');
});


app.listen(3000, (err) => {
    if (!err) {
        console.log('server has started');
    }
});