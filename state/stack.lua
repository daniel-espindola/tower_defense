
local Stack = new(Object) {
  top = 0,
}

function Stack:init()
  self.states = {}
  self.registered = {}
end

function Stack:getState(name)
  if name then
    local state = self.registered[name] if not state then
      state = new('state.' .. name) { stack = self }
      self.registered[name] = state
    end
    return state
  end
end

function Stack:getCurrentState()
  return self:getState(self.states[self.top])
end

function Stack:push(statename, ...)
  local current = self:getCurrentState() if current then
    current:onSuspend()
  end
  self.top = self.top + 1
  self.states[self.top] = statename
  self:getCurrentState():onEnter(...)
end

function Stack:pop()
  self:getCurrentState():onLeave()
  self.states[self.top] = false
  self.top = self.top - 1
  local current = self:getCurrentState() if current then
    current:onResume()
  end
end

return Stack

