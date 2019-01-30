
local FontLoader = new(Object) {
  -- Esta tabela guarda as fontes que já foram carregadas. Cada campo tem um
  -- atributo "path" com o caminho para o arquivo da fonte e um atributo
  -- "fonts" com todos os tamanho criados para essa fonte
  loaded = {}
}

--- Registra a fonte do arquivo passado, associando-a ao nome indicado.
--  Sobrescreve o registro anterior se houver.
function FontLoader:load(font_name, path_to_font_file)
  self.loaded[font_name] = {
      path = path_to_font_file,
      fonts = {}
  }
end

--- Devolve a fonte associada ao nome e tamanho dados.
--  Por padrão, se um tamanho ainda não existe, este método vai criar e guardar
--  o novo tamanho, mas você pode evitar isso indicando que a fonte é
--  temporária.
function FontLoader:get(font_name, size, temporary)
  -- Registro com as informações da fonte
  local font_registry = self.loaded[font_name]
  -- Caso o registro exista, devolve a fonte associada
  if font_registry then
    local font = font_registry.fonts[size]
    -- Se a fonte não existe, cria ela
    if not font then
      font = love.graphics.newFont(font_registry.path, size)
      if not temporary then
          font_registry.fonts[size] = font
      end
    end
    return font
  end
end

--- Configura a fonte atual da LÖVE a partir do nome e tamanho dados.
--  Também funciona passando direto um objeto de fonte. Além disso, é possível
--  criar uma fonte temporária. Devolve o objeto de fonte usado.
function FontLoader:use(font_name_or_font, size, temporary)
  -- Carrega a fonte se foi providenciado um nome e tamanho
  if type(font_name_or_font) == "string" then
    font_name_or_font = self:get(font_name_or_font, size, temporary)
  end
  -- Ativa a fonte e devolve ela
  love.graphics.setFont(font_name_or_font)
  return font_name_or_font
end

return FontLoader

