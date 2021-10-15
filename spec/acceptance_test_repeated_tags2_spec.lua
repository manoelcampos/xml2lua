local xml2lua = require("xml2lua")
local handler = require("xmlhandler.tree")

local luaTable = {
    params = {
        o_param1 = {
            {
                i_param1 = "1",
                _attr = { ATTR = "ATTR_PARAM1" }
            },
            {
                i_param2 = "2",
                _attr = { ATTR = "ATTR_PARAM2" }
            },
        },

        o_param2 = {
            i_param1 = "1",
            i_param2 = {
                ii_param1 = "ii_param1",
                ii_param2 = "ii_param2"
            },
        }
    }
}

local xml = [[
<params>
    <o_param1 ATTR="ATTR_PARAM1">
        <i_param1>1</i_param1>
    </o_param1>
    <o_param1 ATTR="ATTR_PARAM2">
        <i_param2>2</i_param2>
    </o_param1>

    <o_param2>
        <i_param1>1</i_param1>
        <i_param2>
            <ii_param2>ii_param2</ii_param2>
            <ii_param1>ii_param1</ii_param1>
        </i_param2>
    </o_param2>
</params>
]]

describe("Complex Repeated Tags with different structure Acceptance Tests ::", function()
    describe("From XML to lua table ::", function()
        it("parses tags and attributes", function()
            local parser = xml2lua.parser(handler)
            parser:parse(xml)

            local params = handler.root.params
            --xml2lua.printable(handler.root)
            assert.is.equals("table", type(params), "type of 'params' should be table (object)")

            assert.is.equals("table", type(params.o_param1), "type of 'o_param1' should be table (array)")
            assert.is.equals("table", type(params.o_param2), "type of 'o_param2' should be table (object)")

            assert.is.equals("table", type(params.o_param1[1]), "type of 'o_param1[1]' should be table (object)")
            assert.is.equals("1", params.o_param1[1].i_param1)
            assert.is.equals("ATTR_PARAM1", params.o_param1[1]._attr.ATTR)

            assert.is.equals("table", type(params.o_param1[2]), "type of 'o_param1[2]' should be table (object)")
            assert.is.equals("2", params.o_param1[2].i_param2)
            assert.is.equals("ATTR_PARAM2", params.o_param1[2]._attr.ATTR)

            assert.is.equals("1", params.o_param2.i_param1)
            assert.is.equals("table", type(params.o_param2.i_param2), "type of 'o_param2.i_param2' should be table (object)")
            assert.is.equals("ii_param1", params.o_param2.i_param2.ii_param1)
            assert.is.equals("ii_param2", params.o_param2.i_param2.ii_param2)
        end)
    end)

    describe("From lua table to XML ::", function()
        it("parses table members and _attr as attributes", function()
            local parsedXml = xml2lua.toXml(luaTable)
            --print("\nParsed params XML:\n", parsedXml)

            assert.is.truthy(string.find(parsedXml, '<o_param1 ATTR="ATTR_PARAM1">'))
            assert.is.truthy(string.find(parsedXml, '<i_param1>1</i_param1>'))
            assert.is.truthy(string.find(parsedXml, '<o_param2>'))
            assert.is.truthy(string.find(parsedXml, '<ii_param2>ii_param2</ii_param2>'))
        end)
    end)
end)
