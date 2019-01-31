
local font_loader = require 'graphics.font_loader'

local Notification = new 'graphics.drawable' {
  text = 'text',
  font = font_loader:use("bold", 14),
  color = {.9,.4,.3}
}

function Notification:init()
  self.timer_max = 1
  self.timer = self.timer_max
  self.speed = 14
end

function Notification:update(dt)
  self.position.y = self.position.y - self.speed*dt
  self.timer = self.timer - dt
  if self.timer <= 0 then
    self:destroy()
  end
end

function Notification:onDraw()
  local g = love.graphics
  local tx = -self.font:getWidth(self.text)/2
  local ty = -self.font:getHeight(self.text)/2
  local alpha = self.timer/self.timer_max
  g.setColor(self.color[1], self.color[2], self.color[3], alpha)
  font_loader:use(self.font)
  g.print(self.text, tx, ty)
end

return Notification
