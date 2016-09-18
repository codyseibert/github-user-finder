gulp = require 'gulp'
clean = require 'gulp-clean'
del = require 'del'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
nodemon = require 'gulp-nodemon'

gulp.task 'nodemon', ['coffee'], ->
  nodemon
    script: 'dist/server.js'
    ext: 'js'

gulp.task 'clean', ->
  del.sync [ 'dist' ]

gulp.task 'coffee', ->
  gulp.src('src/**/*.coffee')
    .pipe(coffee({bare: true})
    .on('error', gutil.log))
    .pipe(gulp.dest('dist'))

gulp.task 'watch', ->
  gulp.watch 'src/**/*.coffee', [
    'coffee'
  ]

gulp.task 'build', [
  'clean'
  'coffee'
]

gulp.task 'default', [
  'build'
  'nodemon'
  'watch'
]
