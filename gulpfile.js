/* global require */

'use strict';

var gulp = require('gulp'),
    sass = require('gulp-sass'),
    rename = require('gulp-rename'),
    autoprefixer = require('gulp-autoprefixer'),
    minifycss = require('gulp-minify-css');

gulp.task('sass', function () {
  gulp.src('./samlr_com/sass/**/*.scss')
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
  gulp.watch('./samlr_com/sass/**/*.scss', ['sass']);
});
