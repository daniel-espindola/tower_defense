return {
  name = "ZOMBIE2",
  sprite = 'zumbi-azul',
  path = 'enemies.zombie2',
  power = 10,
  cost = 5,
  delay = 2,
  dir = new(Vec) {-1, 0},
  movement = true,
  hitbox = new(Box) {-20,20,-20,20},
  description = ":(",
  group = 'enemies',
  speed = 70,
  max_hp = 150,
}
