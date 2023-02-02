local xml2lua = require("xml2lua")
local handler = require("xmlhandler.tree")

local luaTable = {
    tag = {
        array = {
            item = {
                { _attr = { myattr = "something1" } },
                { _attr = { myattr = "something2" } }
            }
        }
    }
}

local xml = [[
<tag>
  <array>
    <item myattr="something1"/>
    <item myattr="something2"/>
  </array>
</tag>
]]

describe("Simple Repeated Tags with same structure Acceptance Tests ::", function()
    describe("From XML to lua table ::", function()
        it("parses tags and attributes", function()
            local parser = xml2lua.parser(handler)
            parser:parse(xml)

            local tag = handler.root.tag
            xml2lua.printable(handler.root)
            assert.is.equals("table", type(tag), "type of 'tag' should be table (object)")

            local array = tag.array
            assert.is.equals(2, #array.item, "there should have 2 item entries")
            assert.is.equals("table", type(array.item[1]), "type of 'items' should be table (object)")
            assert.is.equals("something1", array.item[1]._attr.myattr) -- it handles attributes

            assert.is.equals("table", type(array.item[2]), "type of 'items' should be table (object)")
            assert.is.equals("something2", array.item[2]._attr.myattr) -- it handles attributes
        end)
    end)

    describe("From lua table to XML ::", function()
        it("parses table members and _attr as attributes", function()
            local parsedXml = xml2lua.toXml(luaTable)
            print("\nParsed array XML:\n", parsedXml, "\n")

            assert.is.truthy(string.find(parsedXml, '<item myattr="something1"'), "there should have an item with a 'something1' myattr value")
            assert.is.truthy(string.find(parsedXml, '<item myattr="something2"'), "there should have an item with a 'something2' myattr value")
            assert.is.falsy(string.find(parsedXml, "non-existent"))
        end)
    end)
end)
