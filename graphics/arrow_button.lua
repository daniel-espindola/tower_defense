
local ArrowButton = new 'graphics.button' {
  side = 'left',
  box = new(Box) { -32, 32, -32, 32 }
}

function ArrowButton:init()
  assert(self.side == 'left' or self.side == 'right')
end

function ArrowButton:onDraw()
  local g = love.graphics
  local color = { .3, .3, .3 }
  if self:isMouseInside() then
    color = { .2, .8, .2 }
  end
  g.setColor(color)
  if self.side == 'left' then
    g.polygon('fill', -24, 0, 16, -12, 16, 12)
  elseif self.side == 'right' then
    g.polygon('fill', 24, 0, -16, -12, -16, 12)
  end
end

return ArrowButton

