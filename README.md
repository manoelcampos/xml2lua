
# xml2lua-1.0-0 [![Build Status](https://travis-ci.org/manoelcampos/xml2lua.svg?branch=master)](https://travis-ci.org/manoelcampos/xml2lua) [![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

xml2lua is an XML parser written entirely in Lua which doesn't depend on any external C/C++ library. 

This version was adapted to work with Lua 5 and can be used in Lua applications, including
interactive Digital Television [Ginga NCL applications](http://gingancl.org.br/en) for the [Brazilian Digital Television System](http://forumsbtvd.org.br) 
(worldwide known as [ISDB-T International or ISDB-Tb](https://en.wikipedia.org/wiki/ISDB-T_International)) and [H.761 ITU-T recommendation](https://www.itu.int/rec/T-REC-H.761).

The original parser was written by Paul Chakravarti and is available on [LuaUsers](http://lua-users.org/wiki/LuaXml).

The code (and documentation) is not complete yet, however it is usable and this release is indented to avoid potential duplication between efforts and get early feedback.

The API is relatively stable however there may be some detailed changes.

# Installation
If you clone this repository, you are download all the module source code and can run the examples directly.
However, if you want to use the module inside your own project, the best way is to download it using 
LuaRocks at the command line:

```bash
luarocks install xml2lua
```

# How to use
A simplified example which parses an XML directly from a string is presented below:

```lua
require("xml2lua")
--Uses a handler that converts the XML to a Lua table
local handler = require("xmlhandler/tree")

local xml = [[
<people>
  <person type="P">
    <name>Manoel</name>
    <city>Palmas-TO</city>
  </person>
  <person type="J">
    <name>University of Brasília</name>
    <city>Brasília-DF</city>
  </person>  
</people>    
]]

--Instantiates the XML parser
local parser = xml2lua.parser(handler)
parser:parse(xml)

--Manually prints the table (since the XML structure for this example is previously known)
for k, p in pairs(handler.root.people.person) do
  print("Name:", p.name, "City:", p.city, "Type:", p._attr.type)
end
```

There are some examples in the root directory, such as the [example1.lua](example1.lua). 

# Command line tool
You can use a command line tool to try parsing XML files.
Execute `lua testxml.lua -help` on the terminal for more details.

# License
This code is freely distributable under the terms of the [MIT license](LICENSE).

# Authors
  - Paul Chakravarti paulc@passtheaardvark.com
  - Manoel Campos da Silva Filho http://about.me/manoelcampos
