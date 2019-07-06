import Transform from require 'Stream'
JSON=require 'JSON'

ArrayOutputStream=Transform\extend!
ArrayOutputStream.initialize=() =>
	Transform.initialize @, {objectMode: true}
	@first=true

ArrayOutputStream._transform=(object, cb) =>
	if @first
		@\push '['..JSON.stringify(object)
		@first=false
	else
		@\push ','..JSON.stringify(object)
	cb!

ArrayOutputStream._end=(...) =>
	@\push ']'
	Transform._end @, ...

ArrayOutputStream
