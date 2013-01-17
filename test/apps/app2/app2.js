
var http = require('http');

http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('app2');
}).listen(9002);

console.log('Server running on port 9002');
