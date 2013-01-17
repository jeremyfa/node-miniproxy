
require('../bin/miniproxy.js').use(__dirname+'/apps').listen(8000, '127.0.0.1', function() {
    console.log("ready.");
});
