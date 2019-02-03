return {
  name = "Bullet",
  speed = 500,
  hitbox = new(Box) { -4, 4, -4, 4 },
  group = 'bullets',
  dir = new(Vec) {1,0},
  view = {
    color = { .65, .85, 1 },
    type = 'circle',
    params = { 'fill',  0, 0, 4}
  }
}

