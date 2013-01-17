
var http = require('http');

http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('app3');
}).listen(9003);

console.log('Server running on port 9003');
