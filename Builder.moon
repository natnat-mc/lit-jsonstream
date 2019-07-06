JSON=require 'JSON'
import Object from require 'core'

Builder=Object\extend!
Builder.initialize=(@writer) =>
	@stack={}
	@top=0

propertyStart=(name) =>
	unless @stack[@top] or @top==0
		@.writer ','
	@stack[@top]=false
	if name
		@.writer JSON.stringify name
		@.writer ':'

depthIncrease=() =>
	@top=@top+1
	@stack[@top]=true

depthDecrease=() =>
	@stack[@top]=nil
	@top=@top-1

Builder.startObject=(name=nil) =>
	propertyStart @, name
	depthIncrease @
	@.writer '{'
	return @

Builder.endObject=() =>
	depthDecrease @
	@.writer '}'
	return @

Builder.startArray=(name=nil) =>
	propertyStart @, name
	depthIncrease @
	@.writer '['
	return @

Builder.endArray=() =>
	depthDecrease @
	@.writer ']'
	return @

Builder.put=(value, name=nil) =>
	propertyStart @, name
	@.writer JSON.stringify value
	return @

Builder
