
var http = require('http');

http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('app1');
}).listen(9001);

console.log('Server running on port 9001');
