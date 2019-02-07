return {
  name = "ZOMBIE3",
  sprite = 'zumbi-boss',
  path = 'enemies.zombie3',
  power = 100,
  cost = 20,
  delay = 2,
  dir = new (Vec) {-1,0},
  movement = true,
  hitbox = new(Box) {-20,20,-20,20},
  description = ":(",
  group = 'enemies',
  max_hp = 300,
  speed = 15,
}