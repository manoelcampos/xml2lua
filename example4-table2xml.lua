#!/usr/bin/env lua

---Sample application showing how to convert a Lua Table to an XML representation
--@author Manoel Campos da Silva Filho - http://manoelcampos.com

local xml2lua = require("xml2lua")
print("xml2lua v" .. xml2lua._VERSION.."\n")

local people = {
    person = {
        {_attr={type="natural"}, name="Manoel", city="Palmas-TO"},
        {_attr={type="natural"}, name="Breno", city="Palmas-TO"},
        {_attr={type="legal"}, name="University of Brasília", city="Brasília-DF"}
    }
}

print("People Table\n")
xml2lua.printable(people)
print("\n------------------------------------------------------\n")

print("XML Representation\n")
print(xml2lua.toXml(people))
