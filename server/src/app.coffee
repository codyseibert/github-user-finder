express = require 'express'
bodyParser = require 'body-parser'
cors = require 'cors'
log4js = require 'log4js'

module.exports = do ->
  logger = log4js.getLogger 'app'
  app = express()
  app.use log4js.connectLogger(logger, level: log4js.levels.TRACE)
  app.use bodyParser.json()
  app.use cors
    origin: '*'
  app
