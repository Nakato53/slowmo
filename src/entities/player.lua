player = {}

player.new = function()

    local self = {}
    self.physicObj = nil
    self.onground = false
    self.facingRight = 1
    self.arm = {
        image = Assets.images.player_arm, 
        x = 2,
        y = 4,
        rot = 0
    }
    self.init = function()
        self.x = 0;
        self.y = 0;
        self.image =  Peachy.new("/assets/json/player.json", Assets.images.player, "iddle")
    end

    self.update = function(dt)
        self.x, self.y = self.physicObj:getPosition()  
        self.image:update(dt)

        local vx, vy = self.physicObj:getLinearVelocity()
        if(inputManager.currentState.right) then
            self.image:setTag("run")
            self.physicObj:setLinearVelocity(4000*dt, vy)
            self.facingRight = 1
        elseif(inputManager.currentState.left) then
            self.image:setTag("run")
            self.facingRight = -1
            self.physicObj:setLinearVelocity(-4000*dt, vy)
        else
            self.image:setTag("iddle")
            self.physicObj:setLinearVelocity(0, vy)
        end


        if  self.physicObj:enter('ground') then
            self.onground = true
        end
        
        local vx, vy = self.physicObj:getLinearVelocity()
        
        if(inputManager.currentState.space and self.onground ) then
            self.onground=false

            self.physicObj:setLinearVelocity(vx, 0)
            self.physicObj:applyLinearImpulse(0, -100)
            
        end

        if(math.abs(vy)> 10) then
            self.onground = false
        end

        if(self.facingRight == 1) then
            self.arm.rot = math.pi*2 - math.atan2((inputManager.mousePosition.x - self.x-self.arm.x), (inputManager.mousePosition.y - self.y-self.arm.y)) + math.pi/2
        else
            self.arm.rot =  math.pi -math.atan2((inputManager.mousePosition.x - self.x-self.arm.x), (inputManager.mousePosition.y - self.y-self.arm.y)) + math.pi/2
        end
    end

    self.draw = function()
        self.image:draw(self.x,self.y,0,self.facingRight,1,16,23)
        love.graphics.draw(self.arm.image, self.x-(self.arm.x*self.facingRight),self.y-self.arm.y, self.arm.rot, self.facingRight,1, 13, 18)
    end

    self.init()
    return self

end