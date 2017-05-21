var gulp = require('gulp');
var less = require('gulp-less');
var browserify = require('browserify');
var babelify = require('babelify');

var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var sourcemaps = require('gulp-sourcemaps');

var src="./";
var dst="../public/";

var handleError=function(err) {
  console.log(err.toString());
  this.emit('end');
}

gulp.task('less', function() {
    return gulp.src(src+"*.less")
        .pipe(less()).on('error',handleError)
        .pipe(gulp.dest(dst));

});

gulp.task('js',function(){
var bundler = browserify(src+"main.js", { debug: true }).transform(babelify, {presets: ["es2015","react"]});
  return bundler
  .bundle().on('error',handleError)
  .pipe(source('bundle.js'))
  .pipe(buffer())
  .pipe(sourcemaps.init({ loadMaps: true }))
  .pipe(sourcemaps.write(dst))
  .pipe(gulp.dest(dst));
})

gulp.task('watch', function() {
    gulp.watch(src+"*.less", ['less']);
    gulp.watch(src+"**/*.js", ['js']);
});

gulp.task('build', ['less', 'js']);
gulp.task('default', ['build', 'watch']);
