player = {}

player.new = function()

    local self = {}
    self.physicObj = nil
    self.onground = false
    self.facingRight = 1
    self.arm = {
        weapon = weapon.new(Peachy.new("/assets/json/shotgun.json", Assets.images.shotgun, "iddle"), 0.6, 10, 50, 50, Assets.sounds.shotgun_fire,Assets.sounds.shotgun_reload),
        x = 2,
        y = 4,
        rot = 0
    }
    self.init = function()
        self.x = 0;
        self.y = 0;
        self.image =  Peachy.new("/assets/json/player.json", Assets.images.player, "iddle")
        self.image.slideloop = 0
        self.image:onLoop(function() 
            if(self.image.tagName == "slide") then
                self.image.slideloop=self.image.slideloop+1
                if(self.image.slideloop == 2)then
                    self.image.slideloop = 0
                    self.image:setTag("run")
                end
            end
        end)
    end

    self.update = function(dt)
        self.x, self.y = self.physicObj:getPosition()  
        self.image:update(dt)
        self.arm.weapon.update(dt)
        local vx, vy = self.physicObj:getLinearVelocity()
        if(self.image.tagName == "slide") then
            self.physicObj:setLinearVelocity(80*self.facingRight, vy)
        else
            if(inputManager.currentState.right) then
                self.image:setTag("run")
                self.physicObj:setLinearVelocity(80, vy)
                self.facingRight = 1
            elseif(inputManager.currentState.left) then
                    self.image:setTag("run")
                self.facingRight = -1
                self.physicObj:setLinearVelocity(-80, vy)
            else
                    self.image:setTag("iddle")
                self.physicObj:setLinearVelocity(0, vy)
            end

            if  self.physicObj:enter('ground') then
                self.onground = true
            end
            
            if(vy > 10) then
                self.image:setTag("fall")
            end

            if(vy < -10) then
                self.image:setTag("jump")
            end

        end
        
        local vx, vy = self.physicObj:getLinearVelocity()
        
        if(inputManager.currentState.space and self.onground ) then
            self.onground=false
            self.physicObj:setLinearVelocity(vx, 0)
            self.physicObj:applyLinearImpulse(0, -15000)
            
        end
        if(inputManager.currentState.mouseLeft) then
            if(self.arm.weapon.fire()) then
                local newBullet = bullet.new(self.x-(self.arm.x*self.facingRight),self.y-self.arm.y, self.arm.rot,self.facingRight, 500)
            end
        end

        if(inputManager.currentState.ctrl and (self.image.tagName == "run" or self.image.tagName == "iddle") and math.abs(vy) < 10 ) then
            
            self.image:setTag("slide")
        end

        
        if(inputManager.currentState.r ) then
            
            self.arm.weapon.reload()
        end



        if(math.abs(vy)> 10) then
            self.onground = falsed
        end

        if(self.facingRight == 1) then
            self.arm.rot = math.pi*2 - math.atan2((inputManager.mousePosition.x - self.x-self.arm.x), (inputManager.mousePosition.y - self.y-self.arm.y)) + math.pi/2
        else
            self.arm.rot =  math.pi -math.atan2((inputManager.mousePosition.x - self.x-self.arm.x), (inputManager.mousePosition.y - self.y-self.arm.y)) + math.pi/2
        end
    end

    self.draw = function()
        self.image:draw(self.x,self.y,0,self.facingRight,1,16,23)
        self.arm.weapon.image:draw(self.x-(self.arm.x*self.facingRight),self.y-self.arm.y, self.arm.rot, self.facingRight,1, 13, 18)
    end

    self.init()
    return self

end