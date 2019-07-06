local JSON = require('JSON')
local Object
Object = require('core').Object
local Builder = Object:extend()
Builder.initialize = function(self, writer)
  self.writer = writer
  self.stack = { }
  self.top = 0
end
local propertyStart
propertyStart = function(self, name)
  if not (self.stack[self.top] or self.top == 0) then
    self.writer(',')
  end
  self.stack[self.top] = false
  if name then
    self.writer(JSON.stringify(name))
    return self.writer(':')
  end
end
local depthIncrease
depthIncrease = function(self)
  self.top = self.top + 1
  self.stack[self.top] = true
end
local depthDecrease
depthDecrease = function(self)
  self.stack[self.top] = nil
  self.top = self.top - 1
end
Builder.startObject = function(self, name)
  if name == nil then
    name = nil
  end
  propertyStart(self, name)
  depthIncrease(self)
  self.writer('{')
  return self
end
Builder.endObject = function(self)
  depthDecrease(self)
  self.writer('}')
  return self
end
Builder.startArray = function(self, name)
  if name == nil then
    name = nil
  end
  propertyStart(self, name)
  depthIncrease(self)
  self.writer('[')
  return self
end
Builder.endArray = function(self)
  depthDecrease(self)
  self.writer(']')
  return self
end
Builder.put = function(self, value, name)
  if name == nil then
    name = nil
  end
  propertyStart(self, name)
  self.writer(JSON.stringify(value))
  return self
end
return Builder
