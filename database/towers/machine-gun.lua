
return {
  name = "MACHINE GUN",
  path = 'towers.machine-gun',
  sprite = 'sentry-gun',
  power = 10,
  max_hp = 80,
  bullet_name = 'bullet',
  hitbox = new(Box) { -10, 10, -10, 10},
  cost = 30,
  group = 'towers',
  firerate = 4,
  bullet_offset = (new (Vec) {-1,0.35} ) * 30,
  description = "Sentry, comin' up",
}

