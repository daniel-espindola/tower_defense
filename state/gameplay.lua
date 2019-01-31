t = 0
ct = 1

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
  grid = self.grid
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
  
  -- coloca o sprite da torre no grid
  self.grid:put(i, j, tower.sprite, 'Tower Built!')
end

--[[ obsoleto

function Gameplay:createEnemy(i,j,spec)
  local enemy = new 'graphics.enemy_sprite' {
    spec = require('database.enemies.' .. spec),
    grid = grid
  }
  grid:put(i,j,enemy,'Enemy Spawned!')
end--]]

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
      grid = grid
    },
  }
  
  table.insert(self.entities[new_entity.spec.group],new_entity)
  return new_entity
end

function Gameplay:onUpdate(dt)
  -- marca o tempo
  t = t + dt
  
  -- cria inimigos a cada 3.5 segudos
  if(t>3.5) then
    t = 0
    pos = new(Vec) {love.math.random(1,6), 12}
    local enemy = Gameplay:makeEntity('enemies.zombie',pos, 'enemy_sprite')
    grid:put(pos.x,pos.y,enemy.sprite,'Enemy Spawned!')
  end
  
  -- Atualiza a posição dos inimigos
  for _,enemy in pairs(self.entities.enemies) do
    enemy:update(dt)
    grid:put(enemy.pos.x, enemy.pos.y, enemy.sprite,'')
  end
  
  -- mostra os hps das torres (teste)
  --[[
  for _,tower in pairs(self.entities.towers) do
    print(tower.hp .. tower.spec.max_hp)
  end
  --]]
  
  -- Checa se os inimigos chegaram na parte esquerda da tela
  for _,enemy in pairs(self.entities.enemies) do
    if enemy.pos.y == 1 then
      love.event.quit()
    end
  end
  
end

return Gameplay

