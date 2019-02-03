local Entity = new(Object) {
  spec = nil,
  world = nil,
  pos = nil,
  movement = nil,
  hp = nil,
  power = nil,
  cooldown = 0,
  sprite = nil,
  grid = nil,
  graphics = nil,
}

function Entity:init()
  self.pos = self.pos or new(Vec) { 0, 0 }
  self.hp = self.spec.max_hp or 10
  self.movement = self.spec.movement or false
  self.sprite = self.sprite or nil
  self.sprite.position = new(Vec) {400,400}
  self.spec.dir = self.spec.dir or new(Vec) {0,0}
  self.spec.speed = self.spec.speed or 0 
  self.spec.firerate = self.spec.firerate or 0
end

function Entity:setMovement(movement)
  self.movement = movement:normalized()
end

function Entity:update(dt)
  self.sprite.position:translate(self.spec.dir * self.spec.speed * dt)
  self.pos = self.sprite.position
  self.cooldown = self.cooldown + dt
  
  while self.cooldown > 1 / self.spec.firerate do
    self.cooldown = self.cooldown - 1 / self.spec.firerate
    local dir = self.spec.bullet_offset -- Deslocamento da bala em relação à torre, e.g: (-1,.35) spawnaria a bala ao nordeste da torre
    local pos = self.pos - dir
    local bullet = self.Gameplay:makeEntity('bullet', pos, 'bullet_sprite')
    bullet.tower = self
    bullet.sprite.position = pos 
    self.sprite.graphics:add('entities', bullet.sprite)
  end

end

function Entity:collidesWith(other)
  return (self.spec.hitbox + (self.pos)):intersects(other.spec.hitbox + (other.pos))
end

return Entity
