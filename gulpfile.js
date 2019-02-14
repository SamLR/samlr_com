var del  = require('del'),
    exec = require('child_process').exec,
    gulp = require('gulp'),

    autoprefixer = require('gulp-autoprefixer'),
    cleancss     = require('gulp-clean-css'),
    rename       = require('gulp-rename'),
    sass         = require('gulp-sass');

function cleanSass() { return del(['samlr_com/css/*']); }
function cleanSite() { return del(['samlr_com/_site/*']); }
var clean = gulp.parallel(cleanSass, cleanSite);

function styles() {
    return gulp.src('./sass/**/*.scss')
        .pipe(
            sass({ style: 'expanded' }).on('error', sass.logError)
        )
        .pipe(autoprefixer('last 2 version'))
        .pipe(gulp.dest('./samlr_com/css'))
        .pipe(rename({ suffix: '.min' }))
        .pipe(cleancss())
        .pipe(gulp.dest('./samlr_com/css'));
}

function watchStyles() { return gulp.watch('./sass/**/*.scss', styles); }

function buildHtml() {
    return exec( 'pipenv run python externals/Tachikoma/tachikoma.py samlr_com/');
}

exports.build = gulp.series(clean, styles, buildHtml);

exports.styles = styles;
exports.buildHtml = buildHtml;

exports.clean = clean;
exports.cleanSass = cleanSass;
exports.cleanSite = cleanSite;

exports.watchStyles = watchStyles;
exports.default = watchStyles;
