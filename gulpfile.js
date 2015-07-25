/* global require */

'use strict';

var gulp = require('gulp'),
    sass = require('gulp-sass'),
    rename = require('gulp-rename'),
    autoprefixer = require('gulp-autoprefixer'),
    minifycss = require('gulp-minify-css'),
    shell = require('gulp-shell'),
    del = require('del'),
    runSequence = require('run-sequence');

// The tasks we actually want to run
gulp.task('default', ['tachikoma:run', 'sass:watch']);

gulp.task('build', function (cb) {
    runSequence( 'clean', 'sass', 'tachikoma', cb );
});

gulp.task('clean', ['clean-sass', 'clean-site']);

// The sub tasks
gulp.task('sass', function () {
    return gulp.src('./sass/**/*.scss')
        .pipe(
            sass({ style: 'expanded' }).on('error', sass.logError)
        )
        .pipe(autoprefixer('last 2 version'))
        .pipe(gulp.dest('./samlr_com/css'))
        .pipe(rename({ suffix: '.min' }))
        .pipe(minifycss())
        .pipe(gulp.dest('./samlr_com/css'));
});

gulp.task('sass:watch', function () {
    gulp.watch('./sass/**/*.scss', ['sass']);
});

gulp.task('tachikoma:run',
    shell.task('python3 externals/Tachikoma/tachikoma.py -s samlr_com/'));
gulp.task('tachikoma:build',
    shell.task('python3 externals/Tachikoma/tachikoma.py samlr_com/'));

gulp.task('clean-sass', function (cb) {
    del([ 'samlr_com/css/*', 'sass/.sass-cache/*' ], cb);
});

gulp.task('clean-site', function (cb) {
    del(['samlr_com/_site/*'], cb);
});