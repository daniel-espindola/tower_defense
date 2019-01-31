
local Button = new 'graphics.drawable' {
  callback = nil,
}

function Button:init()
  self.callback = self.callback or function() return end
end

function Button:isMouseInside()
  local mpos = new(Vec) { love.mouse.getPosition() }
  return (self.box + self.position):isInside(mpos)
end

function Button:onDraw()
  local g = love.graphics
  g.setColor(.3, .3, .3)
  g.rectangle('fill', self.box:getRectangle())
end

function Button:onMousePressed(pos, button)
  if button == 1 then
    self.callback()
  end
  return true
end

return Button

