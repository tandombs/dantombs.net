const gulp = require('gulp');
const sass = require('gulp-sass');
const browserSync = require('browser-sync').create();

gulp.task('default', () => {
});

gulp.task('sass', () => gulp.src("src/scss/*.scss")
    .pipe(sass())
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
    gulp.watch("app/*.html").on('change', browserSync.reload);
});