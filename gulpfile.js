'use strict';

const gulp = require('gulp');
const util = require('gulp-util');
const runSequence = require('run-sequence');
const path = require('path');

const sass = require('gulp-sass');
const postcss = require('gulp-postcss');
const sourcemaps = require('gulp-sourcemaps');
const autoprefixer = require('autoprefixer');

const inlinesource = require('gulp-inline-source');
const ghPages = require('gulp-gh-pages');
const del = require('del');

const browserSync = require('browser-sync').create();

gulp.task('default', () => {
    util.env.production = true;
    runSequence('build');
});

gulp.task('build', ['clean'], (cb) => {
    let tasks = [['sass', 'misc', 'images'], 'html'];
    util.env.production && tasks.push('clean:css');
    runSequence.apply(this, tasks.concat([cb]));
});

gulp.task('clean', () => del([
    'build'
]));

gulp.task('clean:css', () => del([
    'build/css'
]));

gulp.task('sass', () => gulp.src("src/scss/*.scss")
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(postcss([
        autoprefixer()
    ]))
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest("build/css"))
    .pipe(browserSync.stream())
);

gulp.task('html', () => gulp.src("src/**/*.html")
    .pipe(util.env.production ? inlinesource({
        rootpath: path.resolve('build')
    }) : util.noop())
    .pipe(gulp.dest("build"))
    .pipe(browserSync.stream())
);

gulp.task('images', () => gulp.src("src/images/*")
    .pipe(gulp.dest("build/images"))
    .pipe(browserSync.stream())
);

gulp.task('misc', () => gulp.src([
        "src/CNAME",
        "src/*.txt"
    ])
    .pipe(gulp.dest("build"))
);

gulp.task('dev', ['build'], () => {
    browserSync.init({
        server: "./build"
    });
    gulp.watch("src/scss/*.scss", ['sass']);
    gulp.watch("src/*.html").on('change', browserSync.reload);
});

gulp.task('deploy', () => {
    util.env.production = true;
    runSequence('build', 'gh-pages');
});

gulp.task('gh-pages', () => gulp.src('./build/**/*').pipe(ghPages()));
