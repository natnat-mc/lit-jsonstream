local Writable
Writable = require('stream').Writable
local parse
parse = require('JSON').parse
local ObjectDecodeStream = Writable:extend()
ObjectDecodeStream.initialize = function(self)
  Writable.initialize(self)
  self.remaining = ''
end
ObjectDecodeStream._write = function(self, data, cb)
  data = self.remaining .. data
  local idx = 1
  while true do
    local val, nextidx, err = parse(data, idx)
    if err then
      break
    end
    self:emit('data', val)
    idx = nextidx
  end
  self.remaining = data:sub(idx)
  return cb()
end
return ObjectDecodeStream
