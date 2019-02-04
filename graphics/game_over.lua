local font_loader = require 'graphics.font_loader'
W,H = love.graphics.getDimensions()

local gameOver = new 'graphics.drawable' {
  text = 'text',
  font = font_loader:use("bold", 50),
  color = {1,.5,.5,.8},
  position = new(Vec) {W/2,H/2},
}
function gameOver:init()

end
function gameOver:onDraw()
  local g = love.graphics
  g.setColor(unpack(color))
  font_loader:use(self.font)
  g.print("GAME OVER", g.getDimensions())
end

return gameOver