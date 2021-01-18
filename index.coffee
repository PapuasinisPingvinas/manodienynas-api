# Module imports, server listener init
import './scraper.coffee'


express = require 'express'
bodyParser = require 'body-parser'
app = express()
port = process.env.PORT || 3000
app.listen port
console.log 'API is running on 127.0.0.1:' + port
app.use bodyParser.json()


# API code
app.get '/', (req, res) ->
    res.send '<title>Redirecting...</title><script>window.location.replace("https://papuasinispingvinas.github.io/manodienynas-api/")</script>'

app.post '/api/classandhomework', (req, res) -> 
    parseCwAndHw = new ClassAndHomework [req.body.email, req.body.password, req.body.args, req.body.id]
    res.json await parseCwAndHw.parse()

app.post '/api/holidays', (req, res) ->
    parseHolidays = new Holidays [req.body.email, req.body.password, req.body.args]
    res.json await parseHolidays.parse()

app.post '/api/timetable', (req, res) ->
    parseTimetable = new Timetable [req.body.email, req.body.password, req.body.args]
    res.json await parseHolidays.parse()

app.post '/api/homework/getid', (req, res) ->
    parseId = new GetID [req.body.email, req.body.password, req.body.args]
    res.json await parseHolidays.parse()
