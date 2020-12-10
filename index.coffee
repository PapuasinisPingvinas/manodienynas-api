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

scrape = (uri, username, password, mode, selector) ->
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
    switch mode
        when 1 then resp =
                        contents: $ selector.text()
        when 2 then resp =
                        1: $('#tab1 > table > tbody > tr:nth-child(2)').text()
                        2: $('#tab1 > table > tbody > tr:nth-child(3)').text()
                        3: $('#tab1 > table > tbody > tr:nth-child(4)').text()
                        4: $('#tab1 > table > tbody > tr:nth-child(5)').text() 
        when 3 then resp =
                        'subjects': [
                                day: [name: 1, value: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(2) > table > tbody > tr:nth-child(1) > td:nth-child(2) > a').text() ],
                        ]
    await browser.close()
    return resp

# API code
app.get '/', (req, res) ->
    res.send '<title>Redirecting...</title><script>window.location.replace("https://papuasinispingvinas.github.io/manodienynas-api/")</script>'

app.post '/api/classandhomework', (req, res) -> 
    res.json await scrape 'https://www.manodienynas.lt/1/lt/ajax/classhomework/home_work_show/' + req.body.id, req.body.username, req.body.password, 1, 'body > table > tbody > tr:nth-child(' + req.body.tr + ') > td:nth-child(' + req.body.td + ')'

app.post '/api/timetable', (req, res) ->
    res.json await scrape 'https://www.manodienynas.lt/1/lt/page/schedule/view', req.body.username, req.body.password, 3

app.post '/api/holidays', (req, res) ->
    res.json await scrape 'https://www.manodienynas.lt/1/lt/page/atostogos/atostogu_rodymas', req.body.username, req.body.password, 2
