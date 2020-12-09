# Module imports, server listener init
express = require("express")
puppeteer = require('puppeteer')
cheerio = require('cheerio')
bodyParser = require("body-parser")
app = express()
port = process.env.PORT || 3000
app.listen port
console.log "Server is running on localhost:" + port
app.use(bodyParser.json())

# Functions
sleep = (ms) ->
  new Promise (resolve) =>
    setTimeout(resolve, ms)

scrape = (uri, username, password, tr, td) ->
    browser = await puppeteer.launch()
    page = await browser.newPage()
    await page.goto uri
    try
        await page.type('[name=username]', username)
    catch error
        console.log error
    await page.type('[name=password]', password)
    await page.click('[name=login_submit]')
    await sleep(1000)
    html_contents = await page.content()
    $ = cheerio.load(html_contents)
    await browser.close()
    return 
        contents: $('body > table > tbody > tr:nth-child(' + tr + ') > td:nth-child(' + td + ')').text()
# API code
app.get '/', (req, res) ->
    res.send "<title>Manodienynas API</title><h1>An API for Manodienynas and <i>maybe</i> Eduka dienynas.</h1>"

app.post '/api/classandhomework', (req, res) -> 
    res.json await scrape('https://www.manodienynas.lt/1/lt/ajax/classhomework/home_work_show/' + req.body.id, req.body.username, req.body.password, req.body.tr, req.body.td)