sceneManager = {}

sceneManager.currentScene = nil

sceneManager.setScene = function(scene)
    sceneManager.currentScene = scene
end

sceneManager.update = function(dt)
    if(sceneManager.currentScene ~= nil) then
        sceneManager.currentScene.update(dt)
    end
end

sceneManager.draw = function()
    if(sceneManager.currentScene ~= nil) then
        sceneManager.currentScene.draw()
    end
end