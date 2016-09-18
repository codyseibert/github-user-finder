var ObjectId, Users, config, lodash, models;

models = require('../models/models');

Users = models.Users;

ObjectId = require('mongoose').Types.ObjectId;

lodash = require('lodash');

config = require('../config/config');

module.exports = (function() {
  return {
    index: function(req, res) {
      return Users.find({}).then(function(users) {
        res.status(200);
        return res.send(users);
      });
    }
  };
})();
