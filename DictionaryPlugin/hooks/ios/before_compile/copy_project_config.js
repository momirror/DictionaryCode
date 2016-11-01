//console.log('------------------Copy Resource and Project Configuration---------------');

var path = require('path'),
    shjs = require('shelljs');
//
var platform = path.join(process.cwd(), 'platforms', 'ios', 'Dictionary.xcodeproj');
var project = path.join(process.cwd(), 'platforms', 'ios', 'Dictionary');
var ios = path.join(process.cwd(), 'platforms', 'ios');
//var resources = path.join(process.cwd(), 'platforms', 'ios', 'Dictionary', 'Resources');
//

shjs.cp('-rf',path.join('plugins', 'DictionaryPlugin', 'src', 'ios', 'project.pbxproj'),platform);
shjs.cp('-rf',path.join('plugins', 'DictionaryPlugin', 'src', 'ios', 'Dictionary-Info.plist'),project);
//shjs.cp('-rf',path.join('plugins', 'DictionaryPlugin', 'src', 'ios', 'Resources/*'),resources);
