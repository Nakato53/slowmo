----
-- Include all required files
----
require('./require')

----
-- Entry point
----
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest") 
    love.window.setMode(config.gameWidth*config.windowScale, config.gameHeight*config.windowScale, {resizable=false})
    gameScreen = offscreen.new(config.gameWidth,config.gameHeight)
    gameScreen.draw = offscreenDraw    
    monster = Peachy.new("assets/json/monster.json", Assets.images.monster, "Poney")

    colorConverter.setBackgroundColor(100,150,150,255)
end

----
-- UPDATE
----
function love.update(dt)
    Timer.update(dt)
    monster:update(dt)
    inputManager.update(dt)
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
    
end

----
-- Draw on the backscreen
----
function offscreenDraw()

    love.graphics.clear();
    colorConverter.setColor(200, 0, 0, 255)
  --  love.graphics.rectangle('fill', 0, 0, 320, 180)

    colorConverter.setColor(255, 255, 255, 255)
    monster:draw(50,50)
   -- love.graphics.draw(Assets.images.test)
end





