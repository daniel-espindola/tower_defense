
local TowerSprite = new 'graphics.sprite' {
  spec = nil
}

function TowerSprite:init()
  assert(self.spec)
  self.filename = self.spec.sprite
  self:loadImage()
  local w,h = self.image:getDimensions()
  local hotspot = self:getHotspot()
  self.box = new(Box) { -hotspot.x, w, -hotspot.y, h }
end

return TowerSprite

