var UsersCtrl, app;

app = require('./app');

UsersCtrl = require('./controllers/users_controller');

module.exports = (function() {
  return app.get('/users', UsersCtrl.index);
})();
