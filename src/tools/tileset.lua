tileset = {}

tileset.new = function(image, cellSize)
    local self = {}

    self.image = image

    self.imageWidth = image:getWidth()
    self.imageHeight = image:getHeight()
    self.cellSize = cellSize
    
    self.imageRow = self.imageHeight /  self.cellSize
    self.imageColumn = self.imageWidth /  self.cellSize


    self.getTileById = function(id)
        local idRow = math.floor(id/self.imageColumn)
        local idCol = id%self.imageColumn   
        local quad = love.graphics.newQuad( idCol*self.cellSize, idRow*self.cellSize, self.cellSize, self.cellSize, self.imageWidth, self.imageHeight )
        return quad
    end

    return self
end