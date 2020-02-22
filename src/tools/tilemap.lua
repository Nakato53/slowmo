tilemap = {}


tilemap.new = function(mapfile)
    local self = {}

    self.datas = require(mapfile)

    self.tileset = tileset.new(  love.graphics.newImage(self.datas.tilesets[1].image),self.datas.tilesets[1].tilewidth) 
    
    self.world = Windfield.newWorld(0, 0, true)

    self.collisionsObjects = {}

---
--  Test if it's a collision layer, if yes create all physics objects
---
    for i=1,#self.datas.layers do
        local collisionLayer = "collisions"
        if(self.datas.layers[i].name:sub(1, #collisionLayer) == collisionLayer) then

            for j=1,#self.datas.layers[i].objects do
                local obj = self.datas.layers[i].objects[j]
                local physicObj = nil

                if(obj.shape == "rectangle") then
                    physicObj = self.world:newRectangleCollider(obj.x,obj.y, obj.width, obj.height)
                    physicObj:setType('static')
                    if(obj.type ~= "") then
                        physicObj:setCollisionClass(obj.type)
                    end
                end
                table.insert(self.collisionsObjects, physicObj)
            end

            -- remove the layer as no need to be diplay
            table.remove(self.datas.layers,i)
        end
    end

    self.update = function(dt)
        self.world:update(dt)
    end

    self.draw = function(camera)
        for i=1,#self.datas.layers do
            self.drawLayer(i, camera)
        end
        self.world:draw()
    end

    self.drawLayer = function(layerId, camera)
        for i=1,#self.datas.layers[layerId].data do
            local y = math.floor((i-1)/self.datas.layers[layerId].width)
            local x = (i-1)%self.datas.layers[layerId].width
            if(self.datas.layers[layerId].data[i] ~= 0) then
             love.graphics.draw(self.tileset.image, self.tileset.getTileById(self.datas.layers[layerId].data[i]-1),x*self.tileset.cellSize,y*self.tileset.cellSize)
            end
        end
    end

    return self
end