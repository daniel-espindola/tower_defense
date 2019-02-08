
return {
  name = "MINER",
  path = 'towers.mineradora',
  sprite = 'mining',
  power = 20, -- nesse caso se refere ao tanto de dinheiro que gera
  max_hp = 30,
  firerate = 1/15, -- dita a cada quanto tempo será gerado dinheiro
  hitbox = new(Box) { -10, 10, -10, 10},
  bullet_name = 'bullet',
  cost = 30,
  group = 'towers',
  bullet_offset = (new (Vec) {-1,1} ) * 30,
  description = "Mine money for you",
}

