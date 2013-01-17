
fs = require 'fs'
path = require 'path'
colors = require 'colors'
bouncy = require 'bouncy'

class MiniProxy

    use: (path) ->
        @routes = {}
        # List all files inside path
        fs.readdir path, (err, result) =>
            if err then throw err
            for filename in result
                await fs.stat "#{path}/#{filename}", defer err, stats
                # For each file check if it is a directory
                if stats.isDirectory()
                    # If it is a directory, try to open a package.json file
                    packagePath = "#{path}/#{filename}/package.json"
                    await fs.readFile packagePath, defer err, data
                    if data?
                        json = JSON.parse(''+data)
                        # If we have json, look for "routes" attribute
                        if json.routes?
                            for host, port of json.routes
                                @routes[host] = parseInt(port, 10)

            # Start proxy
            @server = bouncy (req, res, bounce) =>
                index = req.headers.host.indexOf(':')
                if index isnt -1
                    host = req.headers.host[0...index]
                else
                    host = req.headers.host
                port = @routes[host]
                if port?
                    bounce port
                else
                    res.statusCode = 404
                    res.end('invalid host')
            @server.listen @port

            # Display proxy configuration
            console.log "proxy from port #{(''+@port).green}"
            for host, port of @routes
                console.log "  to port "+"#{port}".green+" when using host "+"#{host}".magenta

            

        @

    listen: (@port, @host) ->
        @


module.exports = new MiniProxy()
