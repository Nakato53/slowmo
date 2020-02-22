weapon = {}


weapon.new = function(image, cooldown, damage, bullets, bulletsMax, soundfire, soundreload)
    local self = {}

    self.sound ={
        fire= soundfire,
        reload = soundreload
    } 
    self.cooldown = cooldown
    self.canFire = 0
    self.damage = damage
    self.image = image
    self.bullets = bullets
    self.bulletsMax = bulletsMax

    self.image:onLoop(function() 
        if(self.image.tagName == "fire") then
                self.image:setTag("iddle")
        end
        if(self.image.tagName == "reload") then
                self.image:setTag("iddle")
                self.bullets = self.bulletsMax
        end
    end)

    self.fire =  function()
        if(self.image.tagName == "iddle") then  
            if(self.canFire<= 0 and self.bullets > 0) then
                self.canFire = self.cooldown
                self.bullets = self.bullets - 1
                self.image:setTag("fire")

                self.sound.fire:setPitch( (0.4+SLOWFACTOR*0.6 ))
                if(self.sound.fire:isPlaying() ) then
                    self.sound.fire:stop()
                end
                self.sound.fire:play()
                return true
            end
        end
        return false
    end

    self.reload = function()      
        if(self.image.tagName == "iddle") then  
            self.image:setTag("reload")
            if(self.sound.reload:isPlaying() ) then
                self.sound.reload:stop()
            end
            self.sound.reload:setPitch(1+math.random()*0.2)
            self.sound.reload:play()
        end
    end

    self.update = function(dt)
        self.canFire = self.canFire-dt
        self.image:update(dt)
        
    end

    return self
end
