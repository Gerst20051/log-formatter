stylus = require 'gulp-stylus'
debug = require 'gulp-debug'
plumber = require 'gulp-plumber'
concat = require 'gulp-concat'
cleanCss = require 'gulp-clean-css'
sourcemaps = require 'gulp-sourcemaps'

module.exports = (gulp) ->
  ->
    gulp.src('./src/client/stylus/**/*.styl')
      .pipe debug({ title: 'STYLUS FILE:' })
      .pipe plumber()
      .pipe stylus()
      .pipe plumber.stop()
      .pipe concat('main.css')
      .pipe sourcemaps.init()
      .pipe cleanCss()
      .pipe sourcemaps.write()
      .pipe gulp.dest('./public/assets/css')
    return
