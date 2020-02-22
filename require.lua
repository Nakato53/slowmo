
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

----
-- Load tools
----
require('./src/tools/offscreen');
require('./src/tools/colorConverter');

----
-- Load managers
----
require('./src/managers/inputManager');
require('./src/managers/sceneManager');