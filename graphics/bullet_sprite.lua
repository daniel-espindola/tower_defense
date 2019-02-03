
local Bullet = new 'graphics.drawable' {
  spec = nil
}

function Bullet:init()
  assert(self.spec)
end

function Bullet:onDraw()
  local g = love.graphics
  v = self.spec.view
  g.setColor(unpack(v.color))
  g[v.type](unpack(v.params))
end
return Bullet