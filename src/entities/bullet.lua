bullet = {}

bullets = {}

bullet.new = function(x, y,direction, facing, lifetime)
    local self = {}
    direction = direction+ (math.random()*0.1)
    self.x = x+math.cos(direction)*14*facing

    local decalCanon = 0
    if(facing == 1) then
        if(direction > math.pi*2+math.pi/1 )then
            decalCanon = -2
        else
            decalCanon = 2
        end
    end
    if(facing == -1) then
        if(direction > math.pi+math.pi/1 )then
            decalCanon = 2
        else
            decalCanon = -2
        end
    end

    self.y = y+math.sin(direction)*14*facing+decalCanon
    self.facing = facing
    self.direction=direction
    self.life = lifetime
    table.insert(bullets,self)
    self.update = function(dt)
        self.life = self.life-700*dt
    end

    self.draw = function()
        colorConverter.setColor(200,200,200,self.life)
        love.graphics.line(self.x, self.y, self.x+math.cos(self.direction)*400*self.facing,self.y+math.sin(self.direction)*400*self.facing)
        colorConverter.setColor(255,255,255,255)
    end

    return self
end

bulletsClear = function()
    for i=#bullets,1 do
        table.remove(bullets, i)
    end
end
bulletsUpdate = function(dt)
    if(#bullets > 0) then
        for i=#bullets,1,-1 do
            bullets[i].update(dt)
            if(bullets[i].life <= 0) then
                table.remove(bullets, i)
            end
        end
    end
end
bulletsDraw = function()
    if(#bullets > 0) then
        for i=#bullets,1,-1 do
            bullets[i].draw()
        end
    end
end