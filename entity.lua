local Entity = new(Object) {
  spec = nil,
  world = nil,
  pos = nil,
  movement = nil,
  hp = nil,
  firerate = 0,
  power = nil,
  cooldown = 0,
  sprite = nil,
  grid = nil,
}

function Entity:init()
  self.pos = self.pos or new(Vec) { 0, 0 }
  self.hp = self.spec.max_hp or 10
  self.movement = self.spec.movement or false
  self.sprite = self.sprite or nil
  self.sprite.position = new(Vec) {400,400}
  self.spec.speed = self.spec.speed or 0
end

function Entity:setMovement(movement)
  self.movement = movement:normalized()
end

function Entity:update(dt)
  self.sprite.position:translate(new(Vec){-1,0} * self.spec.speed * dt)
  self.pos = self.sprite.position
end

function Entity:collidesWith(other)
  return (self.spec.hitbox + (self.pos)):intersects(other.spec.hitbox + (other.pos))
end

return Entity
