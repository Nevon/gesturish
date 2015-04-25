var browserify   = require('browserify');
var browserSync  = require('browser-sync');
var watchify     = require('watchify');
var mergeStream  = require('merge-stream');
var bundleLogger = require('../util/bundleLogger');
var gulp         = require('gulp');
var handleErrors = require('../util/handleErrors');
var source       = require('vinyl-source-stream');
var config       = require('../config').browserify;
var _            = require('lodash');

var browserifyTask = function(devMode) {

  var browserifyThis = function(bundleConfig) {

    if(devMode) {
      _.extend(bundleConfig, watchify.args, { debug: true });
      // A watchify require/external bug that prevents proper recompiling,
      // so (for now) we'll ignore these options during development. Running
      // `gulp browserify` directly will properly require and externalize.
      bundleConfig = _.omit(bundleConfig, ['external', 'require']);
    }

    var b = browserify(bundleConfig);

    var bundle = function() {
      bundleLogger.start(bundleConfig.outputName);

      return b
        .bundle()
        .on('error', handleErrors)
        .pipe(source(bundleConfig.outputName))
        .pipe(gulp.dest(bundleConfig.dest))
        .pipe(browserSync.reload({
          stream: true
        }));
    };

    if(devMode) {
      b = watchify(b);
      b.on('update', bundle);
      bundleLogger.watch(bundleConfig.outputName);
    } else {
      if(bundleConfig.require) b.require(bundleConfig.require);
      if(bundleConfig.external) b.external(bundleConfig.external);
    }

    return bundle();
  };

  return mergeStream.apply(gulp, _.map(config.bundleConfigs, browserifyThis));

};

gulp.task('browserify', function() {
  return browserifyTask()
});

module.exports = browserifyTask;
