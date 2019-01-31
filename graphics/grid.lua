
local Grid = new 'graphics.drawable' {
  rows = 6,
  columns = 12,
  tilesize = 64,
  color = { 0.2, 0.2, 0.2 },
  valid_highlight_color = { 0, 1, 0, .4},
  invalid_highlight_color = { 1, 0, 0, .4},
  map = nil,
  selected_callback = nil
}

function Grid:init()
  local W, H = love.graphics.getDimensions()
  W = W - 240
  self.box = new(Box) { 0, self.columns * self.tilesize, 0,
                        self.rows * self.tilesize }
  self.position = new(Vec) { 240 + (W - (self.box.right - self.box.left)) / 2,
                             (H - (self.box.bottom - self.box.top)) / 2 }
  self.map = {}
  for i = 1, self.rows do
    self.map[i] = {}
    for j = 1, self.columns do
      self.map[i][j] = false
    end
  end
end

function Grid:onDraw()
  local g = love.graphics
  local tilesize = self.tilesize

  -- Desenha a grade
  g.setColor(self.color)
  g.setLineWidth(2)
  for i=0,self.rows do
    g.line(0, i * tilesize, self.columns * tilesize, i * tilesize)
  end
  for j=0,self.columns do
    g.line(j * tilesize, 0, j * tilesize, self.rows * tilesize)
  end

  -- Desenha os destaques
  local mpos = new(Vec) { love.mouse.getPosition() } - self.position
  local i, j = self:pointToTile(mpos)
  if i and j then
    if self.map[i][j] then
      g.setColor(self.invalid_highlight_color)
    else
      g.setColor(self.valid_highlight_color)
    end
    g.rectangle("fill", (j-1)*tilesize, (i-1)*tilesize, tilesize, tilesize)
  end

end

function Grid:onMousePressed(pos, button)
  if button == 1 then
    local i, j = self:pointToTile(pos)
    if self:isEmpty(i, j) and self.selected_callback then
      self.selected_callback(i, j)
    end
  end
  return true
end

function Grid:pointToTile(point)
  if point.x <= 0 or point.x > self.columns*self.tilesize or
     point.y <= 0 or point.y > self.rows*self.tilesize
  then
    return false
  end
  return math.ceil(point.y/self.tilesize), math.ceil(point.x/self.tilesize)
end

function Grid:isEmpty(i, j)
  return not self.map[i][j]
end

function Grid:put(i, j, object,text)
  self.map[i][j] = object
  self.graphics:add('entities', object)
  object.position = self.position
                  + new(Vec) { j - 0.5, i - 0.5 } * self.tilesize
  local not_pos = new(Vec) {object.position.x,
                            object.position.y - self.tilesize/2}
  local notification = new 'graphics.notification' {
    position = not_pos,
    text = text
  }
  self.graphics:add('fx', notification)
end

return Grid
