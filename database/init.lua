
local DB = new(Object) {}

function DB:each(category)
  local files = love.filesystem.getDirectoryItems("database/" .. category)
  for i,filename in ipairs(files) do
    files[i] = filename:sub(1, -5)
  end
  return ipairs(files)
end

return DB

