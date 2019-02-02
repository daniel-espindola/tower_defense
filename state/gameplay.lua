local t = 0
local timer = 0

local Gameplay = new 'state.base' {
  graphics = nil,
  grid = nil,
  counter = nil,
  tower_specs = nil,
  buy_buttons = nil,
  selected = 1,
  page = 1,
  page_num = 1,
  entities = {enemies = {}, towers = {}},
  removed = {enemies = {}, towers = {}},
  spawn_cd = 3,
}

function Gameplay:onEnter(graphics)
  self.graphics = graphics
  self:loadTowerSpecs()
  self:createGrid()
  self:createBuyButtons()
  self:createArrowButtons()
  self:createCounter()
  self:changeTowers(1)
end

function Gameplay:loadTowerSpecs()
  self.tower_specs = {}
  for i,specname in require 'database' :each('towers') do
    self.tower_specs[i] = require('database.towers.' .. specname)
  end
  self.page_num = math.ceil(#self.tower_specs / 4)
end

function Gameplay:changeTowers()
  for i=1,4 do
    local k = (self.page - 1) * 4 + i
    self.buy_buttons[i].tower_spec = self.tower_specs[k]
  end
  self:selectTower(1)
end

function Gameplay:createGrid()
  self.grid = new 'graphics.grid' {}
  self.grid.selected_callback = function(i, j) self:buildTower(i, j) end
  self.graphics:add('bg', self.grid)
end

function Gameplay:createBuyButtons()
  self.buy_buttons = {}
  local W,H = love.graphics.getDimensions()
  for i=1,4 do
    local buy_button
    buy_button = new 'graphics.buy_button' { index = i }
    buy_button.callback = function() self:selectTower(i) end
    self.buy_buttons[i] = buy_button
    self.graphics:add('gui', buy_button)
  end
end

function Gameplay:createArrowButtons()
  local W,H = love.graphics.getDimensions()
  self.graphics:add('gui', new 'graphics.arrow_button' {
    side = 'left',
    position = new(Vec) { 240 / 4, 3 * H / 4 + 40 },
    callback = function()
      self.page = math.max(1, self.page - 1)
      self:changeTowers()
    end
  })
  self.graphics:add('gui', new 'graphics.arrow_button' {
    side = 'right',
    position = new(Vec) { 3 * 240 / 4, 3 * H / 4 + 40 },
    callback = function()
      self.page = math.min(self.page_num, self.page + 1)
      self:changeTowers()
    end
  })
end

function Gameplay:createCounter()
  self.counter = new 'graphics.counter' {}
  self.counter:add(100)
  self.graphics:add('gui', self.counter)
end

function Gameplay:buildTower(i, j, spec)
  local spec = self.buy_buttons[self.selected].tower_spec
  local tower_sprite = new 'graphics.tower_sprite' {
    spec = spec,
    grid = self.grid
  }
  -- cria o objeto torre e coloca o sprite da torre dentro dele
  local tower = Gameplay:makeEntity(spec.path,new(Vec) {i,j}, 'tower_sprite')
  tower.sprite = tower_sprite
  tower.gridPos = {i,j}
  -- coloca o sprite da torre no grid
  self.grid:put(i, j, tower.sprite, 'Tower Built!')
end


function Gameplay:selectTower(i)
  local button = self.buy_buttons[i]
  if button.tower_spec then
    self.buy_buttons[self.selected].selected = false
    button.selected = true
    self.selected = i
  end
end

function Gameplay:makeEntity(specname,pos,sprite_name)
  local spec = require('database.' .. specname)
  local new_entity = new 'entity' {
    pos = new(Vec) { pos:get() },
    spec = spec,
    
    gameplay = self, -- referência ao gameplay pra poder criar projéteis posteriormente
    sprite = new ('graphics.' .. sprite_name)  {
      spec = spec,
      grid = self.grid
    },
  }
  table.insert(self.entities[new_entity.spec.group],new_entity)
  return new_entity
end

function Gameplay:onUpdate(dt)
  -- marca o tempo
  t = t + dt
  timer = timer + dt
  
  -- a cada 60 segundos diminui o cooldown de spawn dos inimigos
  if timer>60 then 
    timer = 0
    self.spawn_cd = math.min(0.5, self.spawn_cd-0.5)
  end
  
  -- cria inimigos a cada 1.5 segudos
  if(t>self.spawn_cd) then
    t = -100
    pos = new(Vec) {love.math.random(1,6), 12} -- posição no grid (y,x)
    local enemy = Gameplay:makeEntity('enemies.zombie',pos, 'enemy_sprite')
    -- calcula o pixel posição da sprite baseado nas informações do grid
    local position = self.grid.position + new(Vec) {pos.y-0.5, pos.x-0.5} * self.grid.tilesize
    enemy.sprite.position = position
    self.graphics:add('fx', enemy.sprite)
  end
  
  -- Atualiza as torres e os inimigos 
  for _,enemy in pairs(self.entities.enemies) do
    enemy:update(dt)
  end
  for _,tower in pairs(self.entities.towers) do
    tower:update(dt)
  end
  --
  
  -- mostra os hps das torres (teste)
  --[[for _,tower in pairs(self.entities.towers) do
    print(tower.hp .. "   " .. tower.spec.max_hp)
  end--]]
  
  -- checa se houve dano às torres 
  local n = #self.entities.enemies
  local m = #self.entities.towers

  for i = 1,n do
    local enemy = self.entities.enemies[i]
    for j = 1,m do
      local tower = self.entities.towers[j]
      
      if enemy:collidesWith(tower) then
        tower.hp = tower.hp - enemy.spec.power -- remove a vida da torre 
        enemy.sprite.position.x = enemy.sprite.position.x + 100 -- joga o inimigo 100 pixels pra trás
        if tower.hp <= 0  then
          self.removed.towers[j] = true          
        end
      end
    end
  end

  -- remove as torres com vida menor que 0
  -- testar se a posição continua válida
  for i = 1, m do
    if self.removed.towers[i] then
      self.grid:remove(unpack(self.entities.towers[i].gridPos)) -- torna a posição do grid válida de novo
      self.entities.towers[i].sprite:destroy() -- para de desenhar o sprite
      table.remove(self.entities.towers, i) -- mata a entidade
      self.removed.towers[i] = false
    end
  end

  -- não usar os tamanhos das tables towers e enemies dps daqui
  -- Checa se os inimigos chegaram na parte esquerda da tela
  -- Falta desenhar a tela de game over
  for _,enemy in pairs(self.entities.enemies) do
    if enemy.sprite.position.x - self.grid.position.x <= 20 then
      love.event.quit()
    end
  end
  
end


return Gameplay

