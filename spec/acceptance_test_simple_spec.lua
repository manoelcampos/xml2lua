local xml2lua = require("xml2lua")
local handler = require("xmlhandler.tree")

local simple_lua_with_attributes = {
  {age=42, name="Manoela", salary=42.1, city="Brasília-DF", _attr={ type="legal" }, music={_attr={like="true"}} },
  {age=42, name="Manoel", salary=42.1, city="Palmas-TO", _attr={ type="natural" }, music={_attr={like="true"}} },
}

local simple_xml_with_attributes = [[<people>
  <person type="legal">
    <age>42</age>
    <name>Manoela</name>
    <salary>42.1</salary>
    <city>Brasília-DF</city>
    <music like="true"/>
  </person>
  <person type="natural">
    <age>42</age>
    <name>Manoel</name>
    <salary>42.1</salary>
    <city>Palmas-TO</city>
    <music like="true"/>
  </person>
</people>
]]

describe("Basic structure with attributes Acceptance Tests ::", function()
  describe("From XML to lua table ::", function()
    it("parses tags and attributes", function()
      local parser = xml2lua.parser(handler)
      parser:parse(simple_xml_with_attributes)
      local people = handler.root.people

      assert.is.equals(2, #people.person, "there should have 2 people")

      assert.is.equals("Manoela", people.person[1].name)
      assert.is.equals("42", people.person[1].age) -- it handles number
      assert.is.equals("42.1", people.person[1].salary) -- it handles number
      assert.is.equals("legal", people.person[1]._attr.type) -- it handles attributes
      assert.is.equals("true", people.person[1].music._attr.like) -- it single node attributes (boolean value)

      assert.is.equals("Manoel", people.person[2].name) -- it handles string
      assert.is.equals("42", people.person[2].age) -- it handles number
      assert.is.equals("42.1", people.person[2].salary) -- it handles number
      assert.is.equals("natural", people.person[2]._attr.type) -- it handles attributes
      assert.is.equals("true", people.person[2].music._attr.like) -- it single node attributes (boolean value)
    end)
  end)

  describe("From lua table to XML ::", function()
    it("parses table members and _attr as attributes", function()
      local parsedXml = xml2lua.toXml(simple_lua_with_attributes, "people")

      assert.is.truthy(string.find(parsedXml, "Manoela"))
      assert.is.truthy(string.find(parsedXml, "Manoel"))
      assert.is.falsy(string.find(parsedXml, "Manuca"))
    end)
  end)
end)
