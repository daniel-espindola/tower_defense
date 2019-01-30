
local BuyButton = new 'graphics.button' {
  index = 1,
  tower_spec = nil,
  selected = false
}

function BuyButton:init()
  local W,H = love.graphics.getDimensions()
  self.position = new(Vec) { 20, H / 12 + (self.index - 1) * H / 6 }
  self.box = new(Box) { 0, 200, 0, H / 6 }
  self.selected = false
end

function BuyButton:onDraw()
  if self.tower_spec then
    local g = love.graphics

    if self.selected then
      g.setColor(.3, .3, .3)
      g.rectangle('fill', self.box:getRectangle())
    end

    if self.selected or self:isMouseInside() then
      if self.selected then
        g.setColor(.2, .8, .2)
      else
        g.setColor(.1, .4, .1)
      end
      g.setLineWidth(16)
      g.line(self.box.right, self.box.top, self.box.right, self.box.bottom)
    end

    local font_loader = require 'graphics.font_loader'
    local font = font_loader:use("bold", 12)
    local left, top, right = self.box.left + 8, self.box.top + 16,
                             self.box.right - 8
    local tower = self.tower_spec
    g.setColor(1,1,1)
    g.print(tower.name, left, top)
    g.print("Power: "..tower.power, left, top + 16)
    g.print("Cost: "..tower.cost, left, top + 32)
    font_loader:use("regular", 12)
    g.printf(tower.description, left, top + 48, right - left)
  end
end

return BuyButton

