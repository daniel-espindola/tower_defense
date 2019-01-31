
function new(parent)
  if type(parent) == 'string' then
    parent = require(parent)
  end
  parent.__index = parent
  return function (object)
    setmetatable(object, parent)
    local init = parent.init
    if init then init(object) end
    return object
  end
end

Object = new { } { }

Vec = require 'common.vec'
Box = require 'common.box'

