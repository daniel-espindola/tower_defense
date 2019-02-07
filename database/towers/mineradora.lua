
return {
  name = "MINERADORA",
  path = 'towers.mineradora',
  sprite = 'mining',
  power = 10, -- nesse caso se refere ao tanto de dinheiro que gera
  max_hp = 5,
  firerate = 1/10, -- dita a cada quanto tempo será gerado dinheiro
  hitbox = new(Box) { -10, 10, -10, 10},
  bullet_name = 'bullet',
  cost = 30,
  group = 'towers',
  bullet_offset = (new (Vec) {-1,1} ) * 30,
  description = "Make money",
}

