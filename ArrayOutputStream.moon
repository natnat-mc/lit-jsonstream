import Transform from require 'Stream'
import stringify from require 'JSON'

ArrayOutputStream=Transform\extend!
ArrayOutputStream.initialize=() =>
	Transform.initialize @, {objectMode: true}
	@first=true

ArrayOutputStream._transform=(object, cb) =>
	if @first
		@\push '['..stringify(object)
		@first=false
	else
		@\push ','..stringify(object)
	cb!

ArrayOutputStream._end=(...) =>
	@\push ']'
	Transform._end @, ...

ArrayOutputStream
