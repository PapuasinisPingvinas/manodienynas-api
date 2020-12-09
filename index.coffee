# Module imports, server listener init
express = require 'express'
puppeteer = require 'puppeteer'
cheerio = require 'cheerio' 
bodyParser = require "body-parser"
app = express()
port = process.env.PORT || 3000
app.listen port
console.log "Server is running on localhost:" + port
app.use bodyParser.json()

# Objects
todomsg =
    'TODO': 'API'

# Functions
sleep = (ms) ->
  new Promise (resolve) =>
    setTimeout resolve, ms

scrape = (uri, username, password, selector) ->
    browser = await puppeteer.launch()
    page = await browser.newPage()
    await page.goto uri
    try
        await page.type '[name=username]', username
    catch error
        console.log error
    await page.type '[name=password]', password
    await page.click '[name=login_submit]'
    await sleep 1000
    html_contents = await page.content()
    $ = cheerio.load html_contents
    await browser.close()
    return 
        contents: $(selector).text()

# API code
app.get '/', (req, res) ->
    res.send '<title>Manodienynas API</title><h1>An API for Manodienynas and <i>maybe</i> Eduka dienynas.</h1>'

app.post '/api/classandhomework', (req, res) -> 
    res.json await scrape 'https://www.manodienynas.lt/1/lt/ajax/classhomework/home_work_show/' + req.body.id, req.body.username, req.body.password, 'body > table > tbody > tr:nth-child(' + req.body.tr + ') > td:nth-child(' + req.body.td + ')'

app.post '/api/timetable', (req, res) ->
    res.json todomsg

app.post '/api/holidays', (req, res) ->
    res.json await scrape 'https://www.manodienynas.lt/1/lt/page/atostogos/atostogu_rodymas', req.body.username, req.body.password, '#tab1 > table > tbody > tr:nth-child(2) > td.pagelistbord'
