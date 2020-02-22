offscreen = {}
function offscreen.new(screenWidth, screenHeight)
----
-- create the newScreen object
----
    local self = {}

----
-- create the render screen as a canvas
----
    self.renderScreen = love.graphics.newCanvas(config.gameWidth, config.gameHeight)
    
----
-- Set the render target to the canvas
----
    self.beginDraw = function()
        love.graphics.setCanvas(self.renderScreen)
    end

----
-- Set the render to the main window
----

    self.endDraw = function()
        love.graphics.setCanvas()
        love.graphics.setColor(1, 1, 1, 1)
    end

----
-- Let the function empty to be assign later
----
    self.draw = function(fnDraw)
        self.beginDraw()
        fnDraw()
        self.endDraw()
    end

    return self
end
