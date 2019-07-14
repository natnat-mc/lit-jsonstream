import Writable from require 'stream'
import parse from require 'JSON'

ObjectDecodeStream=Writable\extend!
ObjectDecodeStream.initialize=() =>
	Writable.initialize @
	@remaining=''

ObjectDecodeStream._write=(data, cb) =>
	data=@remaining..data
	idx=1
	while true
		val, nextidx, err=parse data, idx
		break if err
		@emit 'data', val
		idx=nextidx
	@remaining=data\sub idx
	cb!

ObjectDecodeStream
