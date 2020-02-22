testscene = {}

testscene.new = function()
    local self = {}
    self.slowmo = 0
    self.slowmoTimer = nil
    self.player = nil
    self.init = function()
        --    self.baseTileset = tileset.new(Assets.images.tilesheettest,16)
        self.baseMap = tilemap.new("assets/maps/testmap")
        Camera:setWorld(0,0,self.baseMap.datas.width*self.baseMap.datas.tilewidth,self.baseMap.datas.height*self.baseMap.datas.tileheight)
        
        self.player = player.new()
        self.player.x = self.baseMap.objects.player.x
        self.player.y = self.baseMap.objects.player.y
        self.player.physicObj = self.baseMap.world:newCircleCollider(self.player.x,self.player.y, 8)
    end
    
    self.update = function(dt)
        Camera:setPosition(self.player.x, self.player.y)

        if(inputManager.isPressedThisFrame("shift")) then
             if(self.slowmoTimer == nil) then
                self.slowmoTimer = Timer.every(0.05, function () self.fadeInSlowmo() end)
             end
        end



        local slowDT = dt * (0.4+(1-math.min(1,self.slowmo/255))*0.6 )
        print(slowDT)
        self.player.update(slowDT)

        self.baseMap.update(slowDT)
    end
    
    self.fadeInSlowmo = function()
        self.slowmo = self.slowmo+15
        if(self.slowmo >= 255) then
            self.slowmoTimer:remove()
            
            Timer.after(5, function ()  self.slowmoTimer = Timer.every(0.05, function () self.fadeOutSlowmo() end)  end)
           
        end
    end
    
    self.fadeOutSlowmo = function()
        self.slowmo = self.slowmo-15
        if(self.slowmo <= 0) then
            self.slowmoTimer:remove()
            self.slowmoTimer=nil
            self.slowmo = 0
        end
    end

    self.draw = function()
        love.graphics.clear(0.7,0.7,0.7,1)
        Camera:draw(function(l,t,w,h)
            self.baseMap.draw()
            self.player.draw()

        end)



        colorConverter.setColor(255,255,255, self.slowmo)
        love.graphics.draw(Assets.images.slowmo,0,0,0,3,3)
        colorConverter.setColor(255,255,255, 255)


    end

    self.init()
    
    return self
end
