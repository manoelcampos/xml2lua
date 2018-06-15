
# xml2lua [![Build Status](https://travis-ci.org/manoelcampos/xml2lua.svg?branch=master)](https://travis-ci.org/manoelcampos/xml2lua) [![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

xml2lua is an XML parser written entirely in Lua which doesn't depend on any external C/C++ library, 
and works for Lua 5.1 to 5.3.

This version was adapted to work with Lua 5 and can be used in Lua applications, including
interactive Digital Television (DTV) [Ginga NCL applications](http://gingancl.org.br/en) for the [Brazilian DTV System](http://www.dtv.org.br) 
(worldwide known as [ISDB-T International or ISDB-Tb](https://en.wikipedia.org/wiki/ISDB-T_International)).

The original parser was written by Paul Chakravarti and is available on [LuaUsers](http://lua-users.org/wiki/LuaXml).

# Installation
If you clone this repository, you are downloading all the module's sources and can run the examples directly.
However, if you want to use the module inside your own project, the best way is to download it using 
[LuaRocks](https://luarocks.org/modules/manoelcampos/xml2lua) at the command line:

```bash
luarocks install xml2lua
```

# How to use
A simplified example which parses an XML directly from a string is presented below.
There are some caveats to deal with an XML having just one tag.
Check the [example1.lua](example1.lua) for details. 

```lua
local xml2lua = require("xml2lua")
--Uses a handler that converts the XML to a Lua table
local handler = require("xmlhandler.tree")

local xml = [[
<people>
  <person type="natural">
    <name>Manoel</name>
    <city>Palmas-TO</city>
  </person>
  <person type="legal">
    <name>University of Brasília</name>
    <city>Brasília-DF</city>
  </person>  
</people>    
]]

--Instantiates the XML parser
local parser = xml2lua.parser(handler)
parser:parse(xml)

--Manually prints the table (since the XML structure for this example is previously known)
for i, p in pairs(handler.root.people.person) do
  print(i, "Name:", p.name, "City:", p.city, "Type:", p._attr.type)
end
```

# Command line tool
You can use a command line tool to try parsing XML files.
Execute `lua testxml.lua -help` on the terminal for more details.

# License
This code is freely distributable under the terms of the [MIT license](LICENSE).

# Authors
  - Paul Chakravarti paulc@passtheaardvark.com
  - Manoel Campos da Silva Filho http://about.me/manoelcampos
