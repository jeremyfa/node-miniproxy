miniproxy
=========

Run a proxy that routes your different projects using their package.json files.

Uses bouncy as proxy engine.

How does it work?
-----------------

```miniproxy``` explores your apps directory (configurable) and opens each package.json file. If it finds a ```routes``` attribute, it will use it to configure the proxy. Once all the routing info has been gathered, the proxy starts to run.

A basic setup would be:

```
.
|_ proxy.js
|_ nodes_modules/
|   |_ miniproxy
|_ apps/
    |_ app1/
        |_ package.json
        |_ ...
    |_ app2/
        |_ package.json
        |_ ...
    |_ ...

```

Example of package.json containing a ```routes``` attributes:

``` json
{
    "name": "app1",
    "version": "0.1.0",
    "routes": {
        "app1.dev": "9001",
        "www.app1.dev": "9001"
    },
    "scripts": {
        "start": "app1.js"
    }
}
```

After reading this package.json file, ```miniproxy``` will route ```app1.dev``` and ```www.app1.dev``` hosts to ```localhost:9001```.

How to use it
-------------

Install module:

``` bash
npm install miniproxy
```

Use it (proxy.js file example):

``` js
// For each folder inside apps/ directory,
// extract routing info from package.json file
// then start a proxy with these routes on port 80
require('miniproxy').use(__dirname+'/apps').listen(80);
```

If you want to run your proxy continuously, you can use [forever](https://npmjs.org/package/forever):

```
forever start proxy.js
```

Note that your apps are not started by ```miniproxy```. You have to take care of it (launch them with forever may also be a good idea).


