var Requests, Users, models, mongoose;

mongoose = require('mongoose');

Users = require('./users');

Requests = require('./requests');

models = {
  Users: mongoose.model('Users', Users),
  Requests: mongoose.model('Requests', Requests)
};

module.exports = models;
