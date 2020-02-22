testscene = {}

testscene.new = function()
    local self = {}
    self.x = 150
    self.y = 150
    self.init = function()
        --    self.baseTileset = tileset.new(Assets.images.tilesheettest,16)
        self.baseMap = tilemap.new("assets/maps/testmap")
        self.camera = Gamera.new(0,0,self.baseMap.datas.width*self.baseMap.datas.tilewidth,self.baseMap.datas.height*self.baseMap.datas.tileheight)
        self.camera:setWindow(0,0,320,180)
        self.camera:setPosition(0,0)
    end
    
    self.update = function(dt)
        if(inputManager.currentState.left) then
            self.camera.x = self.camera.x -1
        end
        if(inputManager.currentState.right) then
            self.camera.x = self.camera.x +1
        end
        if(inputManager.currentState.up) then
            self.camera.y = self.camera.y -1
        end
        if(inputManager.currentState.down) then 
            self.camera.y = self.camera.y +1
        end
       -- self.camera:setPosition(self.x,self.y)
        print(self.camera:getVisible())
        self.baseMap.update(dt)
    end
    
    
    self.draw = function()
        love.graphics.clear(0.7,0.7,0.7,1)
        self.camera:draw(function(l,t,w,h)
            self.baseMap.draw()
        end)
        --love.graphics.draw(Assets.images.tilesheettest, self.baseTileset.getTileById(self.tileId),50,50)
    end

    self.init()
    
    return self
end
