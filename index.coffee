# Module imports, server listener init
express = require 'express'
bodyParser = require 'body-parser'
app = express()
port = process.env.PORT || 3000
app.listen port
console.log 'API is running on 127.0.0.1:' + port
app.use bodyParser.json()

# API code
app.get '/', (req, res) ->
    res.send '<script>window.location.replace("https://papuasinispingvinas.github.io/manodienynas-api/")</script>'

app.post '/api/classandhomework', (req, res) -> 
    parseCwAndHw = new ClassAndHomework [req.body.email, req.body.password, req.body.args, req.body.id]
    res.json await parseCwAndHw.parse()

app.post '/api/holidays', (req, res) ->
    res.json await parseHolidays [req.body.email, req.body.password, req.body.args]

app.post '/api/timetable', (req, res) ->
    parseTimetable = new Timetable [req.body.email, req.body.password, req.body.args]
    res.json await parseHolidays.parse()

# GetID may not be necessary
###
app.post '/api/homework/getid', (req, res) ->
    parseId = new GetID [req.body.email, req.body.password, req.body.args]
    res.json await parseHolidays.parse()
###

# scraper.coffee
# TODO: Split the files later

puppeteer = require 'puppeteer'
cheerio = require 'cheerio'

sleep = (ms) ->
  new Promise (resolve) =>
    setTimeout resolve, ms

getPrerenderedHtml = (uri, email, password) ->
    browser = await puppeteer.launch()
    page = await browser.newPage()
    await page.goto uri
    try
        await page.type '[name=username]', request[0]
    catch error
        console.log error
    await page.type '[name=password]', request[1]
    await page.click '[name=login_submit]'
    await sleep 1000
    html_contents = await page.content()
    await browser.close()
    return html_contents

scrapeHtmlTables = (html, selectorArray) ->
    $ = cheerio.load(html)
    $((Selectors).text()) for Selectors in selectorArray
    return Selectors

# Class stuff

parseHolidays = (email, password, args) ->
    await scrapeHtmlTables(await getPrerenderedHtml('https://www.manodienynas.lt/1/lt/page/atostogos/atostogu_rodymas', email, password), [
                        '#tab1 > table > tbody > tr:nth-child(2)',
                        '#tab1 > table > tbody > tr:nth-child(3)',
                        '#tab1 > table > tbody > tr:nth-child(4)',
                        '#tab1 > table > tbody > tr:nth-child(5)'
    ])
