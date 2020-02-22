camera = {}

camera.new = function()
    local self = {}
        
    self.x = 0
    self.y = 0
    self.target = nil

    self.update = function(dt)
        if(self.target ~= nil) then
            self.x = self.target.x
            self.y = self.target.y
        end
    end

    return self
end