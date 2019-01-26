#!/usr/bin/env lua

---Sample application to read a XML file and print it on the terminal.
--This example shows how the module deals with duplicated XML tags,
--either if they have a value or not.
--Use of of the XML below and comment the other ones to see the difference
--@author Manoel Campos da Silva Filho - http://manoelcampos.com

local xml2lua = require("xml2lua")
--Uses a handler that converts the XML to a Lua table
local handler = require("xmlhandler.tree")

--local xml = "<tag><tag1/></tag>"
--local xml = "<tag><tag1/><tag1/></tag>"
--local xml = "<tag><tag1>A</tag1><tag1>B</tag1></tag>"
local xml = "<tag><tag1>A</tag1></tag>"

--Instantiates the XML parser
local parser = xml2lua.parser(handler)
parser:parse(xml)

local data = handler.root.tag
if #data.tag1 > 1 then
   data = data.tag1
end

print("\nManual print")
for i, p in pairs(data) do
  print("  " .. i, p)
end

print("\nRecursive print")

--Recursivelly prints the table in an easy-to-ready format
xml2lua.printable(handler.root)
