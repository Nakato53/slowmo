tilemap = {}


tilemap.new = function(mapfile)
    local self = {}

    self.datas = require(mapfile)

    self.tileset = tileset.new(  love.graphics.newImage(self.datas.tilesets[1].image),self.datas.tilesets[1].tilewidth) 
    
    self.world = Windfield.newWorld(0, 0, true)
    self.world:setGravity(0, 250)

    self.world:addCollisionClass('interact')
    self.world:addCollisionClass('npc')
    self.world:addCollisionClass('enemy')
    self.world:addCollisionClass('player', { ignores= {'npc','enemy'} } )
    self.world:addCollisionClass('ground')
    self.collisionsObjects = {}

    
    self.objects = {}
    bulletsClear()

---
--  Test if it's a collision layer, if yes create all physics objects
---
    for i=1,#self.datas.layers do

        ---
        -- Create all collisions objects
        ---
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
                if(obj.shape == "polygon") then
                    local vertices = {}
                    for k=1,#obj.polygon do
                        table.insert(vertices, obj.x + obj.polygon[k].x)
                        table.insert(vertices, obj.y + obj.polygon[k].y)
                    end
                    physicObj = self.world:newPolygonCollider(vertices)
                    physicObj:setType('static')
                    if(obj.type ~= "") then
                        physicObj:setCollisionClass(obj.type)
                    end
                    physicObj:setMass(100)
                end
                table.insert(self.collisionsObjects, physicObj)
            end
        end

        ---
        -- Load all datas
        ---
        local datasLayer = "datas"
        if(self.datas.layers[i].name:sub(1, #datasLayer) == datasLayer) then
            for j=1,#self.datas.layers[i].objects do
                self.objects[self.datas.layers[i].objects[j].name] = self.datas.layers[i].objects[j]
            end
            
        end

    end

    self.update = function(dt)
        self.world:update(dt)
    end

    self.draw = function(camera)
        for i=1,#self.datas.layers do
            if(self.datas.layers[i].type == "tilelayer") then
                self.drawLayer(i, camera)
            end
        end
       -- self.world:draw()
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