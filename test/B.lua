local Builder=require '..'.Builder

Builder:new(io.write):startObject():put('value', 'key'):put(5, 'key2'):startArray('arr'):put(1):put(5):put({1, 2, 3}):endArray():endObject()
