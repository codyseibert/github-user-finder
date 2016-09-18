mongoose = require 'mongoose'
mongoose.Promise = require 'bluebird'
mongoose.connect "mongodb://#{process.env.MONGO_HOST || 'localhost'}/github"
mongoose
