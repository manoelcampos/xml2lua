local xml2lua = require("xml2lua")
local handler = require("xmlhandler.tree")

local luaTable = {
    menus = {
        menu = {
            {description = "ABC", name = "name1", keys = {key = "CTRL+O", content = "Open"}},
            {description = "XYZ", name = "name2", keys = {key = "CTRL+S", content = "Save"}},
        }
    }
}

local xml = [[
<menus>
    <menu>
        <description>ABC</description>
        <name>name1</name>
        <keys>
          <key>CTRL+O</key>
          <content>Open</content>
        </keys>
    </menu>
    <menu>
        <description>XYZ</description>
        <name>name2</name>
        <keys>
          <key>CTRL+S</key>
          <content>Save</content>
        </keys>
    </menu>
</menus>
]]

describe("Complex Repeated Tags with same structure Acceptance Tests ::", function()
    describe("From XML to lua table ::", function()
        it("parses tags and attributes", function()
            local parser = xml2lua.parser(handler)
            parser:parse(xml)

            local menus = handler.root.menus
            --xml2lua.printable(handler.root)
            assert.is.equals("table", type(menus), "type of 'menus' should be table (object)")
            assert.is.equals("table", type(menus.menu), "type of 'menus.menu' should be table (array)")
            assert.is.equals("table", type(menus.menu[1]), "type of 'menus.menu[1]' should be table (object)")
            assert.is.equals("table", type(menus.menu[2]), "type of 'menus.menu[2]' should be table (object)")

            assert.is.equals(2, #menus.menu, "there should have 2 'menu' entries into 'menus' tag")
            assert.is.equals("ABC", menus.menu[1].description)
            assert.is.equals("name1", menus.menu[1].name)
            assert.is.equals("table", type(menus.menu[1].keys), "type of 'keys' should be table (object)")
            assert.is.equals("CTRL+O", menus.menu[1].keys.key, "value for 1st key is not as expected")
            assert.is.equals("Open", menus.menu[1].keys.content, "content for 1st key is not as expected")

            assert.is.equals("XYZ", menus.menu[2].description)
            assert.is.equals("name2", menus.menu[2].name)
            assert.is.equals("table", type(menus.menu[2].keys), "type of 'keys' should be table (object)")
            assert.is.equals("CTRL+S", menus.menu[2].keys.key, "value for 2nd key is not as expected")
            assert.is.equals("Save", menus.menu[2].keys.content, "content for 2nd key is not as expected")
        end)
    end)

    describe("From lua table to XML ::", function()
        it("parses table members and _attr as attributes", function()
            local parsedXml = xml2lua.toXml(luaTable)
            --print("\nParsed menus XML:\n", parsedXml)

            assert.is.truthy(string.find(parsedXml, '<description>ABC</description>'), "there should have a description tag with ABC value")
            assert.is.truthy(string.find(parsedXml, '<description>XYZ</description>'), "there should have a description tag with XYZ value")
        end)
    end)
end)
