gulp = require('gulp')

getTask = (task) ->
  require('./src/server/gulp-tasks/' + task) gulp

gulp.task 'browserify', getTask('browserify')
gulp.task 'pug', getTask('pug')
gulp.task 'stylus', getTask('stylus')
gulp.task 'default', [ 'browserify', 'pug', 'stylus' ]
