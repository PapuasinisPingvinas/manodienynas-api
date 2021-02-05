# libs
puppeteer = require 'puppeteer'
cheerio = require 'cheerio'

#funcs
export sleep = (ms) ->
  new Promise (resolve) =>
    setTimeout resolve, ms

export getPrerenderedHtml = (uri, email, password) ->
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

export scrapeHtmlTables = (html, selectorArray) ->
    $ = cheerio.load(html)
    handle = (Selectors) -> $(Selectors)
    await handle Selectors for Selectors in selectorArray
    return Selectors
export class parsecorrect
    constructor: (@mainArray) ->
        parse: (uriNeeeded) ->
            await getPrerenderedHtml uriNeeeded, @mainArray[0], @mainArray[1]

export class Holidays extends parsecorrect
    parse: ->
        super 'https://www.manodienynas.lt/1/lt/page/atostogos/atostogu_rodymas'

export class Timetable extends parsecorrect
    parse: ->
        super 'https://www.manodienynas.lt/1/lt/page/atostogos/atostogu_rodymas'


export class Holidays extends parsecorrect
    parse: ->
        super 'https://www.manodienynas.lt/1/lt/page/atostogos/atostogu_rodymas'
