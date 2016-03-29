
LuaXML-0.0.5
------------

This is an initial release of LuaXML - a native XML parser for Lua.
The parser was written by Paul Chakravarti and originally available on [LuaUsers](http://lua-users.org/wiki/LuaXml).
This version was adapted to work with Lua 5 and can be used in Lua application, including
Digital Television interactive Ginga NCL applications for the Brazilian Digital Television System,
wordwide known as ISDB-Tb (short for  Integrated Services Digital Broadcasting, Terrestrial, Brazilian version)
and H.761 ITU-T recommendation.

The code (and documentation) is not complete as yet however it is usable
and this release is indented to avoid potential duplication between efforts
and get early feedback.

The API is relatively stable however there may be some detailed changes.

The distribution comprises:

    - README          : This file
    - xml.lua         : Main XML parser module
    - handler.lua     : Standard XML handlers
    - testxml.lua     : Command line test tool
    - xmlrpclib.lua   : XMLRPC marshaller/unmarshaller (incomplete and now probably superseeded)
    - xmlrpc-lua.cgi  : Test XML-RPC server (CGI)
    - cgi.lua         : CGI module to support XMLRPC server
                      (will probably be packaged separately idc)
    - cgitest.cgi     
    - pretty.lua      : Lua pretty printer [23/02/2001 jcw@equi4.com]

Most of the modules are relatively well documented in the source - the key
ones are 'xml.lua' & 'handler.lua'. The 'testxml.lua' utility is also
useful for testing the modules.

This is all being released a bit earlier than I would have liked due
to all the current XML related activity on lua-l and as a result isnt
quite as well packaged/docuemnted as I would like. I will be working
on fixing this asp.

How to use
----------

An example of how to use the library is available [here](example).

License
-------
This code is freely distributable under the terms of the [Lua license](http://www.lua.org/copyright.html)

Authors
-------
  - Paul Chakravarti
    
    paulc@passtheaardvark.com
	
	28 Nov 2001
	
  -  Manoel Campos da Silva Filho
  
	<http://manoelcampos.com>
	
	<http://about.me/manoelcampos>
		
    22 Sep 2015
