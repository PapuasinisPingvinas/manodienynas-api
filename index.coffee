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
                                    days: 'Time': [
                                        1: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(1) > table > tbody > tr:nth-child(1) > td').text(),
                                        2: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(1) > table > tbody > tr:nth-child(2) > td').text(),
                                        3: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(1) > table > tbody > tr:nth-child(3) > td').text(),
                                        4: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(1) > table > tbody > tr:nth-child(4) > td').text(),
                                        5: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(1) > table > tbody > tr:nth-child(5) > td').text(),
                                        6: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(1) > table > tbody > tr:nth-child(6) > td').text(),
                                        7: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(1) > table > tbody > tr:nth-child(7) > td').text(),
                                        8: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(1) > table > tbody > tr:nth-child(8) > td').text(),
                                        9: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(1) > table > tbody > tr:nth-child(9) > td').text()
                                        ],
                                    days : 'Pirmadienis': [
                                        1: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(2) > table > tbody > tr:nth-child(1) > td:nth-child(2) > a').text(),
                                        2: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(2) > table > tbody > tr:nth-child(2) > td:nth-child(2) > a').text(),
                                        3: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(2) > table > tbody > tr:nth-child(3) > td:nth-child(2) > a').text(),
                                        4: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(2) > table > tbody > tr:nth-child(4) > td:nth-child(2) > a').text(),
                                        5: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(2) > table > tbody > tr:nth-child(5) > td:nth-child(2) > a').text(),
                                        6: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(2) > table > tbody > tr:nth-child(6) > td:nth-child(2) > a').text(),
                                        7: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(2) > table > tbody > tr:nth-child(7) > td:nth-child(2) > a').text(),
                                        8: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(2) > table > tbody > tr:nth-child(8) > td:nth-child(2) > a').text(),
                                        9: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(2) > table > tbody > tr:nth-child(9) > td:nth-child(2) > a').text()
                                    ],
                                    days: 'Antradienis': [
                                        1: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(1) > td:nth-child(2) > a').text(),
                                        2: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td:nth-child(2) > a').text(),
                                        3: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(3) > td:nth-child(2) > a').text(),
                                        4: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(4) > td:nth-child(2) > a').text(),
                                        5: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(5) > td:nth-child(2) > a').text(),
                                        6: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(6) > td:nth-child(2) > a').text(),
                                        7: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(7) > td:nth-child(2) > a').text(),
                                        8: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(8) > td:nth-child(2) > a').text(),
                                        9: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(9) > td:nth-child(2) > a').text()
                                    ],
                                    days: 'Trečiadienis': [
                                        1: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(4) > table > tbody > tr:nth-child(1) > td:nth-child(2) > a').text(),
                                        2: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(4) > table > tbody > tr:nth-child(2) > td:nth-child(2) > a').text(),
                                        3: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(4) > table > tbody > tr:nth-child(3) > td:nth-child(2) > a').text(),
                                        4: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(4) > table > tbody > tr:nth-child(4) > td:nth-child(2) > a').text(),
                                        5: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(4) > table > tbody > tr:nth-child(5) > td:nth-child(2) > a').text(),
                                        6: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(4) > table > tbody > tr:nth-child(6) > td:nth-child(2) > a').text(),
                                        7: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(4) > table > tbody > tr:nth-child(7) > td:nth-child(2) > a').text(),
                                        8: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(4) > table > tbody > tr:nth-child(8) > td:nth-child(2) > a').text(),
                                        9: $('#sheduleContTable > tbody > tr:nth-child(2) > td:nth-child(4) > table > tbody > tr:nth-child(9) > td:nth-child(2) > a').text()
                                    ],
                                    days: 'Ketvirtadienis': [
                                        1: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(2) > table > tbody > tr:nth-child(1) > td:nth-child(2) > a').text(),
                                        2: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(2) > table > tbody > tr:nth-child(2) > td:nth-child(2) > a').text(),
                                        3: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(2) > table > tbody > tr:nth-child(3) > td:nth-child(2) > a').text(),
                                        4: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(2) > table > tbody > tr:nth-child(4) > td:nth-child(2) > a').text(),
                                        5: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(2) > table > tbody > tr:nth-child(5) > td:nth-child(2) > a').text(),
                                        6: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(2) > table > tbody > tr:nth-child(6) > td:nth-child(2) > a').text(),
                                        7: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(2) > table > tbody > tr:nth-child(7) > td:nth-child(2) > a').text(),
                                        8: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(2) > table > tbody > tr:nth-child(8) > td:nth-child(2) > a').text(),
                                        9: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(2) > table > tbody > tr:nth-child(9) > td:nth-child(2) > a').text()
                                    ],
                                    days: 'Penktadienis': [
                                        1: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(3) > table > tbody > tr:nth-child(1) > td:nth-child(2) > a').text(),
                                        2: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td:nth-child(2) > a').text(),
                                        3: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(3) > table > tbody > tr:nth-child(3) > td:nth-child(2) > a').text(),
                                        4: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(3) > table > tbody > tr:nth-child(4) > td:nth-child(2) > a').text(),
                                        5: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(3) > table > tbody > tr:nth-child(5) > td:nth-child(2) > a').text(),
                                        6: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(3) > table > tbody > tr:nth-child(6) > td:nth-child(2) > a').text(),
                                        7: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(3) > table > tbody > tr:nth-child(7) > td:nth-child(2) > a').text(),
                                        8: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(3) > table > tbody > tr:nth-child(8) > td:nth-child(2) > a').text(),
                                        9: $('#sheduleContTable > tbody > tr:nth-child(4) > td:nth-child(3) > table > tbody > tr:nth-child(9) > td:nth-child(2) > a').text()                                        
                                    ]
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
