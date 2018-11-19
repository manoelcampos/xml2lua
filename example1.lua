#!/usr/bin/env lua

---Sample application to read a XML file and print it on the terminal.
--@author Manoel Campos da Silva Filho - http://manoelcampos.com

local xml2lua = require("xml2lua")
--Uses a handler that converts the XML to a Lua table
local handler = require("xmlhandler.tree")

local xml = xml2lua.loadFile("people.xml")

--Instantiates the XML parser
local parser = xml2lua.parser(handler)
parser:parse(xml)

--[[
By default, assumes the people table has just one person table.
Iterating over the people table we'll directly get the single person that it represents.
]]
local people = handler.root.people

--[[
If there is more than one person, then person is an array instead of regular table.
This way, we need to iterate over the person array instead of the people table.
]]
if #people.person > 1 then
   people = people.person
end

--Manually prints the table (since the XML structure for this example is previously known)
for i, p in pairs(people) do
  print(i, "Name:", p.name, "City:", p.city, "Type:", p._attr.type)
end

--Recursivelly prints the table in an easy-to-ready format
--xml2lua.printable(handler.root)
