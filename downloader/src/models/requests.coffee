mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

module.exports = new Schema
  url: String
  response: String
  body: Object
  next: String
