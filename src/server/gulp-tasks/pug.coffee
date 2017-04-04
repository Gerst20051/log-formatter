pug = require 'gulp-pug'

module.exports = (gulp) ->
  ->
    gulp.src('./views/index.pug')
    .pipe pug({
      pretty: true
    })
    .pipe gulp.dest('.')
    return
