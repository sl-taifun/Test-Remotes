
-- Metadata

local s = "å1ä2ö3";

local data = libs.data;
local server = libs.server;
------------------------------------------------------------

actions.tojson = function ()
	local lua = {};
	lua.int = 123;
	lua.num = 1.23;
	lua.bool = true;
	lua.arr = { 1, 2, 3 };
	lua.str = "one-two-three";
	lua.obj = {};
	lua.obj.one = 1;
	lua.obj.two = 2;
	lua.obj.three = 3;
	local json = data.tojson(lua);
	server.update({id = "info", text = json });
end

actions.tojson_bad = function ()
	local r = data.tojson("asdf");
	server.update({id = "info", text = r });
end

------------------------------------------------------------

actions.fromjson = function ()
	local json = "{ \"int\": 123, \"num\": 1.23, \"bool\": true, \"str\": \"one-two-three\", \"arr\": [1,2,3], \"obj\": { \"one\": 1, \"two\": 2, \"three\": 3 } }";
	local lua = data.fromjson(json);
	server.update({id = "info", text = lua.obj.three });
end

actions.fromjson_bad = function ()
	local r = data.fromjson("a sdf asdf sdf asfsdf");
	server.update({id = "info", text = r });
end

actions.test = function ()
	local str = "";
	for i=1,4112 do
		str = str .. "a";
	end
	
	print(#str);

	local json = "[\"" .. str .. "\"]";
	libs.fs.write("C:/4111.json", json);
	local lua = data.fromjson(json);
	print(lua);
	--server.update("info", "text", lua);
end

actions.indent = function ()
	libs.log.trace(data.tojsonpretty(
		{ foo = "bar", hello = "world" }
	));
end
