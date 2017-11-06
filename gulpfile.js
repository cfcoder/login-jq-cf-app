var gulp = require('gulp');
var browserSync = require('browser-sync').create();
var sass = require('gulp-sass');
var rename = require('gulp-rename');

gulp.task('serve', function() {
  browserSync.init({
    proxy: "localhost:8500"
  });
});

gulp.task('scss', function () {
  return gulp.src('./scss/*.scss')
    .pipe(sass({outputStyle: 'compressed'}).on('error', sass.logError))
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest('./css'))
    .pipe(browserSync.reload({stream: true})); // prompts a reload after compilation
});

gulp.task('watch', ['serve'], function () {
  gulp.watch("./scss/*.scss", ['scss']);
  gulp.watch("*.cfm").on('change', browserSync.reload);
});

gulp.task('default', function() {
  // place code here for default task
});
