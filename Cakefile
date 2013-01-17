
exec = require('child_process').exec

task 'build', 'Build project from src/*.coffee to bin/*.js', ->
    exec 'iced --runtime inline --compile --output bin/ src/', (err, stdout, stderr) ->
        throw err if err
