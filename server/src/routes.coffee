app = require './app'
UsersCtrl = require './controllers/users_controller'

module.exports = do ->
  app.get '/users', UsersCtrl.index
