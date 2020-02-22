----
-- Include all required files
----
require('./require')

----
-- Entry point
----
function love.load()
    
    --monster = Peachy.new("assets/json/monster.json", Assets.images.monster, "Poney")
    love.graphics.setDefaultFilter("nearest", "nearest") 
    love.window.setMode(config.gameWidth*config.windowScale, config.gameHeight*config.windowScale, {resizable=false})
    gameScreen = offscreen.new(config.gameWidth,config.gameHeight)
    gameScreen.draw = offscreenDraw    
    world = Windfield.newWorld(0, 0, true)
    world:setGravity(0, 512)
    colorConverter.setBackgroundColor(100,150,150,255)

    sceneManager.setScene(testscene.new())
end

----
-- UPDATE
----
function love.update(dt)
    -- monster:update(dt)
    Timer.update(dt)
    inputManager.update(dt)
    world:update(dt)
    sceneManager.update(dt)
end

----
-- DRAW
----
function love.draw()
    love.graphics.clear();
    gameScreen.beginDraw();
    gameScreen.draw();
    gameScreen.endDraw();
    love.graphics.draw(gameScreen.renderScreen, 0, 0, 0, config.windowScale, config.windowScale)
 --   world:draw()
end

----
-- Draw on the backscreen
----
function offscreenDraw()

    love.graphics.clear();
    
    sceneManager.draw()
    
   -- monster:draw(50,50)
   -- love.graphics.draw(Assets.images.test)
end





