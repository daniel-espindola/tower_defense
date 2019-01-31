
local Layer = new(Object) {}

function Layer:init()
  self.drawables = {}
end

function Layer:add(drawable)
  self.drawables[drawable] = true
end

function Layer:update(dt)
  for drawable in pairs(self.drawables) do
    drawable:update(dt)
    if drawable:isDestroyed() then
      self.drawables[drawable] = nil
    end
  end
end

function Layer:onMousePressed(mpos, button)
  for drawable in pairs(self.drawables) do
    if drawable:isInside(mpos) and
       drawable:onMousePressed(mpos - drawable.position, button)
    then
      return true
    end
  end
end

function Layer:onMouseReleased(mpos, button)
  for drawable in pairs(self.drawables) do
    if drawable:onMouseReleased(mpos, button) then
      return true
    end
  end
end

function Layer:draw()
  for object in pairs(self.drawables) do
    object:draw()
  end
end

return Layer

