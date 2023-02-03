#!/usr/bin/env lua
-- Read XML documents containing DOCTYPE and CDATA tags,
-- parse with the dom parser,
-- print the XML documents to STDOUT.
local xml2lua = require("xml2lua")
local xmlhandler = require("xmlhandler.dom")

local files = {"books.xml", "people2.xml"}
for _, file in ipairs(files) do
   print(file, "-----------------------------------------------------------")
   local xml = xml2lua.loadFile(file)
   local dom = xmlhandler:new()
   local parser = xml2lua.parser(dom)
   parser:parse(xml)
   if not dom.root then
      print("parsing ", file , " as XML failed")
   else
      print(dom:toXml(dom.root))
   end
end