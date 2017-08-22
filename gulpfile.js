var gulp = require('gulp');
var sass = require('gulp-sass');
var concatCSS = require('gulp-concat-css');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
var gutil = require('gulp-util');
var csso = require('gulp-csso');
var csscomb = require('gulp-csscomb');
var imagemin = require('gulp-imagemin');
var clean = require('gulp-clean');
var htmlmin = require('gulp-htmlmin');
var ngAnnotate = require('gulp-ng-annotate');

gulp.task('default', ['build'], function(){
    return;
});

gulp.task('build', ['build-css','build-scripts', 'build-img', 'build-html'], function(){
    gulp.src('public/*.ico')
        .pipe(gulp.dest('public/dist'));
    return;
});

// configure which files to watch and what tasks to use on file changes
//gulp.task('watch', function() {
//  gulp.watch('public/**/*.js', ['build']);
//});

//Minifies html
gulp.task('build-html',['clean'],function(){
    return gulp.src('public/**/*.html',{base:'public'})
        .pipe(htmlmin())
        .pipe(gulp.dest('public/dist'));
});

//Cleans distribution folder
gulp.task('clean', function () {  
  return gulp.src('public/dist', {read: false})
    .pipe(clean());
});

// Concatenates & Minifies CSS
gulp.task('build-css', ['clean'],function (){
    return gulp.src('public/app/**/*.css')
        .pipe(concatCSS("styles_bundle.css", {rebaseUrls:false}))
        .pipe(csscomb())
        .pipe(gulp.dest('public/dist'))
        .pipe(csso())
        .pipe(rename("styles_bundle.min.css"))
        .pipe(gulp.dest('public/dist'));
});

//Sass
// gulp.task('build-css', ['clean'], function(){
//     return gulp.src('index.scss')
//         .pipe(sass())
//         .pipe(rename("styles_bundle.css"))
//         .pipe(gulp.dest('public/dist'))
//         .pipe(csso())
//         .pipe(rename("styles_bundle.min.css"))
//         .pipe(gulp.dest('public/dist'));
// });

// Minifies images
gulp.task('build-img', ['clean'],function (){
    return gulp.src('public/images/**/*', {base: 'public'})
        .pipe(imagemin())
        .pipe(gulp.dest('public/dist'));
});

// Concatenates & Minifies JS
gulp.task('build-scripts', ['clean'], function() {
    return gulp.src('public/app/**/*.js')
        .pipe(concat('scripts_bundle.js'))
        .pipe(gulp.dest('public/dist'))
        .pipe(rename('scripts_bundle.min.js'))
        .pipe(ngAnnotate())
        .pipe(uglify().on('error', gutil.log))
        .pipe(gulp.dest('public/dist'));
});