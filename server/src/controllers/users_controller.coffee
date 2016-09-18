models = require '../models/models'
Users = models.Users
ObjectId = require('mongoose').Types.ObjectId
lodash = require 'lodash'
config = require '../config/config'

module.exports = do ->

  index: (req, res) ->
    Users.find({}).then (users) ->
      res.status 200
      res.send users
