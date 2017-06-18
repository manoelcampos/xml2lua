package = "xml2lua"
version = "1.0-0"
source = {
   url = "git://github.com/manoelcampos/xml2lua",
   tag = "v1.0-0"
}
description = {
   summary = "An XML Parser written entirely in Lua 5.",
   detailed = [[
   Enables parsing an XML file and converting it to a Lua table,
   which can be handled directly by your application.
   ]],
   homepage = "http://manoelcampos.github.io/xml2lua/",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, <= 5.2"
}
build = {
  type = "builtin",
  modules = {
      xml2lua = "xml2lua.lua",
      ["xmlhandler.tree"] = "xmlhandler/tree.lua",
      ["xmlhandler.print"] = "xmlhandler/print.lua",
      ["xmlhandler.dom"] = "xmlhandler/dom.lua"
   }  
}