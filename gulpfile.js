const gulp = require('gulp');
const sass = require('gulp-sass');
const browserSync = require('browser-sync').create();
const postcss = require('gulp-postcss');
const sourcemaps = require('gulp-sourcemaps');
const autoprefixer = require('autoprefixer');
const ghPages = require('gulp-gh-pages');

gulp.task('build', ['sass', 'html'], () => true);

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
    .pipe(gulp.dest("build"))
    .pipe(browserSync.stream())
);

gulp.task('dev', ['sass', 'html'], () => {
    browserSync.init({
        server: "./build"
    });
    gulp.watch("src/scss/*.scss", ['sass']);
    gulp.watch("src/*.html").on('change', browserSync.reload);
});

gulp.task('deploy', ['build'], () => {
  return gulp.src('./build/**/*')
    .pipe(ghPages());
});