import {deleteAsync} from 'del';

import {exec}  from 'child_process';

import gulp from 'gulp';
import sass from 'gulp-dart-sass';
import rename from 'gulp-rename';
import cleancss from 'gulp-clean-css';

import autoprefixer from 'gulp-autoprefixer';

function cleanSass() { return deleteAsync(['samlr_com/css/*']); }
function cleanSite() { return deleteAsync(['samlr_com/_site/*']); }
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


var build = gulp.series(clean, styles, buildHtml);

export { build, styles, buildHtml, clean, cleanSass, cleanSite, watchStyles };

export default watchStyles;
