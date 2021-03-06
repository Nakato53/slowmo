----
-- Load config object
----
require('./config')


----
-- Load libs
----
Assets = require('./src/libs/cargo').init('assets');    -- assets loader
Timer = require('./src/libs/knife-timer');              -- timer lib
Windfield = require('./src/libs/windfield');            -- physics engine
Peachy = require("./src/libs/peachy/peachy")            -- animation
Gamera = require("./src/libs/gamera")            -- animation

----
-- Load tools
----
require('./src/tools/offscreen');
require('./src/tools/colorConverter');
require('./src/tools/tileset');
require('./src/tools/tilemap');
require('./src/tools/camera');

----
-- Load managers
----
require('./src/managers/inputManager');
require('./src/managers/sceneManager');


----
-- Load scenes
----
require('./src/scenes/testscene');

----
-- Load entities
----
require('./src/entities/player');
require('./src/entities/weapon');
require('./src/entities/bullet');


function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end