request = require 'request'
Promise = require 'bluebird'
fs = require 'fs'

mongoose = require 'mongoose'

mongoose.Promise = require 'bluebird'
mongoose.connect "mongodb://localhost/github"

models = require './models'
Requests = models.Requests
Users = models.Users

users = []

step = 0

# https://api.github.com/users/codyseibert/events

getUser = (url) ->
  new Promise (resolve, reject) ->
    request
      uri: url
      method: "GET"
      json: true
      headers:
        "User-Agent": "codyseibert"
        'Authorization': 'Basic ' + new Buffer(process.env.USERNAME + ':' + process.env.PASSWORD).toString('base64')
    , (err, response, body) ->
      resolve body

getEvents = (username) ->
  new Promise (resolve, reject) ->
    request
      uri: "https://api.github.com/users/#{username}/events"
      method: "GET"
      json: true
      headers:
        "User-Agent": "codyseibert"
        'Authorization': 'Basic ' + new Buffer(process.env.USERNAME + ':' + process.env.PASSWORD).toString('base64')
    , (err, response, body) ->
      resolve body

requestUsers = (link, users) ->
  new Promise (resolve, reject) ->
    getUsers = (cb) ->
      console.log 'url', link

      Requests.findOne(url: link).then (req) ->
        console.log 'find one finished'

        if step > 0
          console.log 'step'
          return cb true, headers: link: '', []

        if req?
          console.log 'a request was found in mongo'
          cb null, headers: link: req.next, req.body
        else
          request
            uri: link
            method: "GET"
            json: true
            headers:
              "User-Agent": "codyseibert"
              'Authorization': 'Basic ' + new Buffer(process.env.USERNAME + ':' + process.env.PASSWORD).toString('base64')
          , (err, response, body) ->
            console.log err, response.headers, body.length
            cb err, response, body, true

    getUsers (err, response, body, fresh) ->
      console.log 'get users called'
      return reject err if err?

      pp =
        response: JSON.stringify response, null, 2
        body: body
        next: response.headers.link
      console.log 'next', pp.next
      Requests.update url: link, pp, upsert: true
        .then ->
          console.log 'should up updated / inserted the request into mongoose'
          if fresh
            console.log 'fresh as hell'
            promises = []
            for user in body
              promises.push(getUser user.url
                .then (u) ->
                  console.log 'about to update / insert the user'
                  getEvents(u.login)
                    .then (events) ->
                      u.events = events
                      Users.update id: u.id, u, upsert: true
                        .then ->
                          console.log 'updated user'
              )
          else
            console.log 'not fresh'
            promises = [Promise.resolve()]

          Promise.all promises
            .then ->
              console.log 'all user inserts are done'
              if err? or not body? or body.length is 0
                console.log 'error found, ending'
                reject users
              else
                step++
                Array.prototype.push.apply users, body
                resolve
                  link: response.headers.link.split(';')[0].replace('<', '').replace('>', '')
                  users: users

makeRequest = (r) ->
  r
    .then (obj) ->
      makeRequest requestUsers obj.link, obj.users


Requests.remove {}, ->
  Users.remove {}, ->
    makeRequest(new Promise (resolve, reject) ->
      resolve
        link: 'https://api.github.com/users'
        users: []
    )
    .catch (users) ->
      console.log 'users', users.length
