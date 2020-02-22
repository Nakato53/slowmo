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
    }
end

----
-- Initialize all states
----
inputManager.init = function()
    inputManager.currentState = inputManager.resetState()
    inputManager.lastState = inputManager.resetState()  
end


----
-- Update inputs
----
inputManager.update = function(dt)
    inputManager.lastState = inputManager.currentState
    
    inputManager.currentState = inputManager.resetState()

    if love.keyboard.isDown( "left" ) then
        inputManager.currentState.left = true
    end
    if love.keyboard.isDown( "right" ) then
        inputManager.currentState.right = true
    end
    if love.keyboard.isDown( "up" ) then
        inputManager.currentState.up = true
    end
    if love.keyboard.isDown( "down" ) then
        inputManager.currentState.down = true
    end
    if love.keyboard.isDown( "space" ) then
        inputManager.currentState.space = true
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
