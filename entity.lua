local Entity = new(Object) {
  spec = nil,
  world = nil,
  pos = nil,
  movement = nil,
  hp = nil,
  firerate = 0,
  power = nil,
  cooldown = 0
}

function Entity:init()
  self.pos = self.pos or new(Vec) { 0, 0 }
  self.hp = self.spec.max_hp or 10
  self.movement = self.spec.movement or false
end

function Entity:setMovement(movement)
  self.movement = movement:normalized()
end

function Entity:update(dt)
  self.cooldown = self.cooldown + dt
  if self.movement and (self.cooldown > self.spec.delay) then
    self.pos.y = self.pos.y -1
    self.cooldown = 0
  end
end

function Entity:collidesWith(other)
  return (self.spec.hitbox + self.pos):intersects(other.spec.hitbox + other.pos)
end

return Entity
