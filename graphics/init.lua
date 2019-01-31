
local Graphics = new(Object) {
  layers = nil
}

function Graphics:init()
  assert(self.layers)
  for _,layer_id in ipairs(self.layers) do
    self.layers[layer_id] = new 'graphics.layer' {}
  end
end

function Graphics:add(layer, drawable)
  self.layers[layer]:add(drawable)
  drawable.graphics = self
end

function Graphics:update(dt)
  for _,layer_id in ipairs(self.layers) do
    self.layers[layer_id]:update(dt)
  end
end

function Graphics:drawLayers()
  for _, layer_id in ipairs(self.layers) do
    self.layers[layer_id]:draw()
  end
end

function Graphics:onMousePressed(mpos, button)
  for i=#self.layers,1,-1 do
    local layer = self.layers[self.layers[i]]
    if layer:onMousePressed(mpos, button) then return end
  end
end

function Graphics:onMouseReleased(mpos, button)
  for i=#self.layers,1,-1 do
    local layer = self.layers[self.layers[i]]
    if layer:onMouseReleased(mpos, button) then return end
  end
end

return Graphics

