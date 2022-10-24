#!/usr/bin/env lua
-- read a XML document in STDIN,
-- parse with the dom parser,
-- print the XML document to STDOUT.
local xml2lua = require("xml2lua")
local dom = require("xmlhandler.dom")
local parser = xml2lua.parser(dom)
parser:parse(io.read("*all"))
if not dom.root then
   print("parsing as XML failed")
else
   print(dom:toXml(dom.root))
end
