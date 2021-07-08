package = "xml2lua"
version = "1.5-2"
source = {
   url = "git://github.com/manoelcampos/xml2lua",
   tag = "v1.5-2"
}
description = {
   summary = "An XML Parser written entirely in Lua that works for Lua 5.1+",
   detailed = [[
   Enables parsing a XML string into a Lua Table and
   converting a Lua Table to an XML string.
   ]],
   homepage = "http://manoelcampos.github.io/xml2lua/",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, <= 5.4"
}
build = {
  type = "builtin",
  modules = {
      xml2lua = "xml2lua.lua",
      XmlParser = "XmlParser.lua",
      ["xmlhandler.tree"] = "xmlhandler/tree.lua",
      ["xmlhandler.print"] = "xmlhandler/print.lua",
      ["xmlhandler.dom"] = "xmlhandler/dom.lua",
   }  
}
