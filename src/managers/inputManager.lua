----
-- Object creation
----

inputManager = {}

----
-- Define an input state
----
inputManager.resetState = function()
    return {
        left = false,
        up = false,
        right = false,
        down = false,
        space = false ,
        shift = false ,
        r = false ,
    }
end

----
-- Initialize all states
----
inputManager.init = function()
    inputManager.mousePosition = { x=0, y=0 }
    inputManager.currentState = inputManager.resetState()
    inputManager.lastState = inputManager.resetState()  
end


----
-- Update inputs
----
inputManager.update = function(dt)
    inputManager.mousePosition.x, inputManager.mousePosition.y = Camera:toWorld(love.mouse.getPosition()) 
    inputManager.lastState = inputManager.currentState
    
    inputManager.currentState = inputManager.resetState()

    if love.keyboard.isDown( "left" ) or  love.keyboard.isDown( "q" ) or  love.keyboard.isDown( "a" ) then
        inputManager.currentState.left = true
    end
    if love.keyboard.isDown( "right" ) or  love.keyboard.isDown( "d" ) then
        inputManager.currentState.right = true
    end
    if love.keyboard.isDown( "up" ) or  love.keyboard.isDown( "w" )  or  love.keyboard.isDown( "z" )  then
        inputManager.currentState.up = true
    end
    if love.keyboard.isDown( "down" )  or  love.keyboard.isDown( "s" ) then
        inputManager.currentState.down = true
    end
    if love.keyboard.isDown( "space" ) then
        inputManager.currentState.space = true
    end
    if love.keyboard.isDown( "lshift" ) then
        inputManager.currentState.shift = true
    end
    if love.keyboard.isDown( "r" ) then
        inputManager.currentState.r = true
    end
end


----
-- Check if the requested key is pressed this frame and not the previous one
----
inputManager.isPressedThisFrame = function(key)
    if(inputManager.currentState[key] == true and inputManager.lastState[key] == false) then
        return true
    end
    return false
end

----
-- Check if the requested key is release this frame and not the previous one
----
inputManager.isReleaseThisFrame = function(key)
    if(inputManager.currentState[key] == false and inputManager.lastState[key] == true) then
        return true
    end
    return false
end


inputManager.init()