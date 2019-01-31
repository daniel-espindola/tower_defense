
local Base = new(Object) {
  stack = nil -- provided by surpevising state stack
}

function Base:onEnter(params)
  -- abstract method
end

function Base:onLeave()
  -- abstract method
end

function Base:onSuspend()
  -- abstract method
end

function Base:onResume()
  -- abstract method
end

function Base:onUpdate(dt)
  -- abstract method
end

return Base

