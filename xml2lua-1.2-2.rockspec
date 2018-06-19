package = "xml2lua"
version = "1.2-2"
source = {
   url = "git://github.com/manoelcampos/xml2lua",
   tag = "v1.2-2"
}
description = {
   summary = "An XML Parser written entirely in Lua that works for Lua 5.1 to 5.3",
   detailed = [[
   Enables parsing an XML file and converting it to a Lua table,
   which can be handled directly by your application.
   It supports Lua 5.1 to 5.3.
   ]],
   homepage = "http://manoelcampos.github.io/xml2lua/",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, <= 5.3"
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