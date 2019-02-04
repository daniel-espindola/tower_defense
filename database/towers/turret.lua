
return {
  name = "TURRET",
  path = 'towers.turret',
  sprite = 'tesla-turret',
  power = 5,
  max_hp = 120,
  hitbox = new(Box) { -10, 10, -10, 10},
  bullet_name = 'bullet',
  cost = 20,
  group = 'towers',
  firerate = 2,
  bullet_offset = (new(Vec) {-1,0.50}) * 30,
  description = '"10/10 would buy again"',
}

