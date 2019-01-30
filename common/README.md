
# Biblioteca auxiliar `common`

Os módulos Lua nesta pasta fornecem algumas utilidades para facilitar o desenvolvimento dos exercícios e projetos do curso.

Para usar o módulo, basta fazer

```lua
require 'common'
```

Logo no começo do seu `main.lua`. Tem que ser a primeira coisa no arquivo!

Uma vez feito isso, você terá acesso às seguintes funcionalidades:

## Função `new`

```lua
local new_object = new(Parent) {
  attribute1 = 42,
  attribute2 = "foo"
}
```

A função global `new()` é usada para instanciar objetos (filhos) a partir de outros objetos (pais). Ela pode ser chamada de duas maneiras. A primeira maneira, vista acima, cria uma instância diretamente a partir do objeto passado (`Parent`, no exemplo).

```lua
local new_object = new('some.module') { ... }
```

Nessa segunda forma, passamos uma string com o caminho para um arquivo. A função `new` vai usar o objeto devolvido por esse arquivo como objeto pai.

Lembre-se que quando se chama uma função em Lua com apenas um parâmetro do tipo string, os parênteses podem ser omitidos:


```lua
local new_object = new 'some.module' { ... }
```

## Objeto `Object`

```lua
local new_object = new(Object) { ... }
```

Esse é o objeto primordial. Todos os outros objetos herdam dele através de usos da função `new`.

## Objeto `Vec`

```lua
local new_vec = new(Vec) { 0, 0 } -- (x, y)
```

Esse objeto é o vetor primodrial. Todos os vetores herdam dele.

No caso, esse são vetores no sentido de pares ordenados em R², isto é, `(x, y)`, onde `x` é a componente horizontal e `y` é a componente vertical. É aqui que geomtria analítica entra no desenvolvimento de jogos!

É possível realizar operações aritméticas com objetos que herdam de `Vec`, como soma, subtração, multiplicação...

## Objeto `Box`

```lua
local new_box = new(Box) { -10, 10, -10, 10 } -- (left, right, top, bottom)
```

Esse objeto é a caixa primordial. Todas as caixas herdam dela.

Aqui, chamamos de caixa um objeto que representa uma região retangular em R². Ela é representada pelos falor `(left, right, top, bottom)`, que indicam a posição de cada uma dessas extremidades da caixa:

```
  +-------+  <--- top
  |       |
  +-------+  <--- bottom
  ^left   ^right
```

Objetos `Box` servem para detectarmos colisões. Eles sabem dizer se um `Vec` está dentro ou não de si, ou se um outro `Box` intersecta com ele.
