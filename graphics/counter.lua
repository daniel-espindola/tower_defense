
local Counter = new 'graphics.drawable' {
  value = 0,
  change = 0
}

function Counter:init()
  local W, H = love.graphics.getDimensions()
  self.position = new(Vec) { 240/2, 11 * H / 12 }
  self.box = new(Box) { -80, 80, 0, H / 12 }
end

function Counter:getValue()
  return self.value
end

function Counter:add(value)
  self.change = self.change + math.floor(value)
end

function Counter:subtract(value)
  self.change = self.change -math.floor(value)
end

function Counter:update(dt)
  local amount = self.change
  if amount > 0 then
    amount = math.min(amount, 40 * dt)
  elseif amount < 0 then
    amount = math.max(amount, -40 * dt)
  end
  self.change = self.change - amount
  self.value = self.value + amount
end

function Counter:onDraw()
  local g = love.graphics
  local font_loader = require 'graphics.font_loader'
  local left, right, top = self.box:get()
  font_loader:use('regular', 32)
  if self.change > 0 then
    g.setColor(0, 1, 0)
  elseif self.change < 0 then
    g.setColor(1, 0, 1)
  else
    g.setColor(1, 1, 1)
  end
  g.printf(("%d $"):format(self.value), left, top, right - left, 'right')
end

return Counter

