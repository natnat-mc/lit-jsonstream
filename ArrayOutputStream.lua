local Transform
Transform = require('Stream').Transform
local stringify
stringify = require('JSON').stringify
local ArrayOutputStream = Transform:extend()
ArrayOutputStream.initialize = function(self)
  Transform.initialize(self, {
    objectMode = true
  })
  self.first = true
end
ArrayOutputStream._transform = function(self, object, cb)
  if self.first then
    self:push('[' .. stringify(object))
    self.first = false
  else
    self:push(',' .. stringify(object))
  end
  return cb()
end
ArrayOutputStream._end = function(self, ...)
  self:push(']')
  return Transform._end(self, ...)
end
return ArrayOutputStream
