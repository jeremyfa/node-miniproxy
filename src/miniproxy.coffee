
fs = require 'fs'
path = require 'path'
colors = require 'colors'
proxy = require 'http-proxy'

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

            router = {}
            for host, port of @routes
                router[host] = "#{host}:#{port}"

            # Start proxy
            proxy.createServer(hostnameOnly: true, router: router).listen(@port)


            # Display proxy configuration
            console.log "proxy from port #{(''+@port).green}"
            for host, port of @routes
                console.log "  to port "+"#{port}".green+" when using host "+"#{host}".magenta

            @callback?()

        @

    listen: (@port, @host, @callback) ->
        if not @host? then @host = '127.0.0.1'
        @


module.exports = new MiniProxy()
