----
-- Include all required files
----
require('./require')

----
-- Entry point
----
Camera = nil
SLOWFACTOR = 1
function love.load()
    
    --monster = Peachy.new("assets/json/monster.json", Assets.images.monster, "Poney")

    love.graphics.setDefaultFilter("nearest", "nearest") 
    love.window.setMode(config.gameWidth*config.windowScale, config.gameHeight*config.windowScale, {resizable=false})
    gameScreen = offscreen.new(config.gameWidth,config.gameHeight)
    colorConverter.setBackgroundColor(100,150,150,255)
    
    Camera = Gamera.new(0,0,config.gameWidth*config.windowScale,config.gameHeight*config.windowScale)
    Camera:setWindow(0,0,960,540)
    Camera:setPosition(0,0)
    Camera:setScale(3)

    sceneManager.setScene(testscene.new())
end

----
-- UPDATE
----
function love.update(dt)
    -- monster:update(dt)
    Timer.update(dt)
    inputManager.update(dt)
    sceneManager.update(dt)
end

----
-- DRAW
----
function love.draw()
    love.graphics.clear();
    sceneManager.draw()
   -- gameScreen.draw(function() 
   --     offscreenDraw()
  --  end)
    
 --   love.graphics.draw(gameScreen.renderScreen, 0, 0, 0, config.windowScale, config.windowScale)
 end

----
-- Draw on the backscreen
----
function offscreenDraw()
    love.graphics.clear();
    sceneManager.draw()
end





