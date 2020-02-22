testscene = {}

testscene.new = function()
    local self = {}
    self.slowmo = 0
    self.slowmoTimer = nil
    self.music =  Assets.sounds.backloop
    self.music:setLooping(true)
    self.player = nil
    self.init = function()
        --    self.baseTileset = tileset.new(Assets.images.tilesheettest,16)
        self.baseMap = tilemap.new("assets/maps/labo")
        Camera:setWorld(0,0,self.baseMap.datas.width*self.baseMap.datas.tilewidth,self.baseMap.datas.height*self.baseMap.datas.tileheight)
        
        self.player = player.new()
        self.player.x = self.baseMap.objects.player.x
        self.player.y = self.baseMap.objects.player.y
        self.player.physicObj = self.baseMap.world:newCircleCollider(self.player.x,self.player.y, 8)
        self.player.physicObj:setMass(100)
        self.music:play()
        self.music:setVolume(0.2)
        self.music:setPitch(1)
    end
    
    self.update = function(dt)
        
        Camera:setPosition(self.player.x, self.player.y)

        if(inputManager.isPressedThisFrame("shift")) then
             if(self.slowmoTimer == nil) then
                self.slowmoTimer = Timer.every(0.05, function () self.fadeInSlowmo() end)
             end
        end
        
        
    
        SLOWFACTOR = math.max(1-math.min(1,self.slowmo/255),0.01)
        --print(SLOWFACTOR)
        local slowDT = dt * (0.4+(SLOWFACTOR)*0.6 )
        self.music:setPitch (0.4+SLOWFACTOR*0.6 )
        self.player.update(slowDT)

        bulletsUpdate(slowDT)
        self.baseMap.update(slowDT)
    end
    
    self.fadeInSlowmo = function()
        self.slowmo = self.slowmo+15
        if(self.slowmo >= 255) then
            self.slowmoTimer:remove()
            
            Timer.after(Assets.datas.game.bullettime_secondes, function ()  self.slowmoTimer = Timer.every(0.05, function () self.fadeOutSlowmo() end)  end)
           
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
            bulletsDraw()
        end)



        colorConverter.setColor(255,255,255, self.slowmo)
        love.graphics.draw(Assets.images.slowmo,0,0,0,3,3)
        colorConverter.setColor(255,255,255, 255)


    end

    self.init()
    
    return self
end
