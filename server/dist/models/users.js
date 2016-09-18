var ObjectId, Schema, mongoose;

mongoose = require('mongoose');

Schema = mongoose.Schema;

ObjectId = Schema.ObjectId;

module.exports = new Schema({
  login: String,
  id: Number,
  avatar_url: String,
  gravatar_id: String,
  url: String,
  html_url: String,
  followers_url: String,
  following_url: String,
  gists_url: String,
  starred_url: String,
  subscriptions_url: String,
  organizations_url: String,
  repos_url: String,
  events_url: String,
  received_events_url: String,
  type: String,
  site_admin: Boolean,
  name: String,
  company: String,
  blog: String,
  location: String,
  email: String,
  hireable: Boolean,
  bio: String,
  public_repos: Number,
  public_gists: Number,
  followers: Number,
  following: Number
});
