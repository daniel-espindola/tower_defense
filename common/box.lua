
local Box = new(Object) {}

function Box:init()
  self.left = self.left or self[1] or 0
  self.right = self.right or self[2] or 0
  self.top = self.top or self[3] or 0
  self.bottom = self.bottom or self[4] or 0
end

function Box:__tostring()
  return string.format("box: left=%.2f right=%.2f top=%.2f bottom=%.2f",
                       self:get())
end

function Box:get()
  return self.left, self.right, self.top, self.bottom
end

function Box:set(left, right, top, bottom)
  self.left = left or self.left
  self.right = right or self.right
  self.top = top or self.top
  self.bottom = bottom or self.bottom
end

function Box:getDimensions()
  return self.right - self.left, self.bottom - self.top
end

function Box:getRectangle()
  return self.left, self.top, self:getDimensions()
end

function Box:__add(vec)
  return new(Box) { self.left + vec.x, self.right + vec.x,
                    self.top + vec.y, self.bottom + vec.y }
end

function Box:isInside(point)
  return point.x >= self.left and point.x <= self.right and
         point.y >= self.top and point.y <= self.bottom
end

function Box:intersects(other)
  if self.left > other.right or
     self.right < other.left or
     self.top > other.bottom or
     self.bottom < other.top
  then 
    return false
  else
    return true
  end
end

return Box

