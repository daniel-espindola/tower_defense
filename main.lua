
require 'common'

local _state_stack
local _graphics

function love.load()

  DEBUG = false

  -- Carrega fontes de texto usadas no jogo
  local font_loader = require 'graphics.font_loader'
  font_loader:load("regular", "assets/fonts/Orbitron-Regular.ttf")
  font_loader:load("bold", "assets/fonts/Orbitron-Bold.ttf")

  -- Cria gerenciador de gráficos
  _graphics = new 'graphics' {
    layers = { 'bg', 'entities', 'gui', 'fx' }
  }
  love.graphics.setBackgroundColor(.1, .1, .1)

  -- Cria uma nova pilha de estados e empilha o estado principal
  _state_stack = new 'state.stack' {}
  _state_stack:push('gameplay', _graphics)

end

function love.update(dt)
  _state_stack:getCurrentState():onUpdate(dt)
  _graphics:update(dt)
end

function love.draw()
  _graphics:drawLayers()
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

function love.mousepressed(x, y, button)
  _graphics:onMousePressed(new(Vec) {x, y}, button)
end

function love.mousereleased(...)
  _graphics:onMouseReleased(new(Vec) {x, y}, button)
end

