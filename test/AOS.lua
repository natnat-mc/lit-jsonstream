local ArrayOutputStream=require '..'.ArrayOutputStream

local a=ArrayOutputStream:new()
a:pipe(process.stdout)

a:write("a string")
a:write(5)
a:write{1, 2, 3}
a:_end()
