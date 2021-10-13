#!/usr/bin/env lua

---Sample application showing how to convert a Lua Table to an XML representation
--@author @DusanNikolicc11 

local xml2lua = require("xml2lua")
print("xml2lua v" .. xml2lua._VERSION.."\n")

local body = {
    ["xs:complexType"] = {
        _attr = {
            abstract = "true",
            name = "complexType"
        },
        ["xs:complexContent"] = {
            ["xs:extension"] ={
                _attr = { base = "xs:annotated" },
                ["xs:group"] = {
                    _attr = { ref = "xs:complexTypeModel" }
                },
                ["xs:attribute"] = {
                    {
                        ["xs:annotation"] = {
                            ["xs:documentation"] = "Will be restricted to required or forbidden"
                        }
                    },
                    {
                        _attr = {
                            default = "false",
                            name = "mixed",
                            type= "xs:boolean",
                            use = "optional"
                        },
                        ["xs:annotation"] = {
                            ["xs:documentation"] = "Not allowed if simpleContent child is chosen. May be overriden by etting on complexContent child"
                        }
                    },
                    {
                        _attr = {
                            default = "false",
                            name = "abstract",
                            type = "xs:boolean",
                            use = "optional"
                        }
                    },
                    {
                        _attr = {
                            name = "final",
                            type = "xs:derivationSet",
                        }
                    },
                    {
                        _attr = {
                            name = "block",
                            type = "xs:derivationSet",
                        }
                    }
                },
            }
        }
    }
}

print("Documentation Table\n")
xml2lua.printable(body)
print("\n------------------------------------------------------\n")

print("XML Representation\n")
print(xml2lua.toXml(body))

--[[
Expected output:
<xs:complexType name="complexType" abstract="true">
    <xs:complexContent>
        <xs:extension base="xs:annotated">
            <xs:attribute>
                <xs:annotation>
                     <xs:documentation>Will be restricted to required or forbidden</xs:documentation>
                 </xs:annotation>
             </xs:attribute>
             <xs:attribute name="mixed" type="xs:boolean" default="false" use="optional">
                 <xs:annotation>
                     <xs:documentation>Not allowed if simpleContent child is chosen. May be overriden by etting on complexContent child</xs:documentation>
                 </xs:annotation>
             </xs:attribute>
             <xs:attribute name="abstract" type="xs:boolean" default="false" use="optional">
             </xs:attribute>
             <xs:attribute name="final" type="xs:derivationSet">
             </xs:attribute>
             <xs:attribute name="block" type="xs:derivationSet">
             </xs:attribute>
             <xs:group ref="xs:complexTypeModel">
             </xs:group>
         </xs:extension>
    </xs:complexContent>
</xs:complexType>
]]
