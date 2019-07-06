local Transform
Transform = require('Stream').Transform
local JSON = require('JSON')
local ArrayOutputStream = Transform:extend()
ArrayOutputStream.initialize = function(self)
  Transform.initialize(self, {
    objectMode = true
  })
  self.first = true
end
ArrayOutputStream._transform = function(self, object, cb)
  if self.first then
    self:push('[' .. JSON.stringify(object))
    self.first = false
  else
    self:push(',' .. JSON.stringify(object))
  end
  return cb()
end
ArrayOutputStream._end = function(self, ...)
  self:push(']')
  return Transform._end(self, ...)
end
return ArrayOutputStream
