---- @module Handler to generate a DOM-like node tree structure with 
--      a single ROOT node parent - each node is a table comprising 
--      fields below.
--  
--      node = { _name = <Element Name>,
--              _type = ROOT|ELEMENT|TEXT|COMMENT|PI|DECL|DTD,
--              _attr = { Node attributes - see callback API },
--              _parent = <Parent Node>
--              _children = { List of child nodes - ROOT/NODE only }
--            }
--      where:
--      - PI = XML Processing Instruction tag.
--      - DECL = XML declaration tag
--
--      The dom structure is capable of representing any valid XML document
--
-- Options
-- =======
--    options.(comment|pi|dtd|decl)Node = bool 
--        - Include/exclude given node types
--
--  License:
--  ========
--
--      This code is freely distributable under the terms of the [MIT license](LICENSE).
--
--@author Paul Chakravarti (paulc@passtheaardvark.com)
--@author Manoel Campos da Silva Filho
local dom = {
    options = {commentNode=1, piNode=1, dtdNode=1, declNode=1},
    root = { _children = {n=0}, _type = "ROOT" },
    current = root        
}

---Parses a start tag.
-- @param tag a {name, attrs} table
-- where name is the name of the tag and attrs 
-- is a table containing the atributtes of the tag
function dom:starttag(tag)
    local node = { _type = 'ELEMENT', 
                   _name = tag.name, 
                   _attr = tag.attrs, 
                   _parent = self.current, 
                   _children = {n=0} 
                 }

    table.insert(self.current._children, node)
    self.current = node
end

---Parses an end tag.
-- @param tag a {name, attrs} table
-- where name is the name of the tag and attrs 
-- is a table containing the atributtes of the tag
function dom:endtag(tag, s)
    if tag.name ~= self.current._name then
        error("XML Error - Unmatched Tag ["..s..":"..tag.name.."]\n")
    end
    self.current = self.current._parent
end

---Parses a tag content.
-- @param text text to process
function dom:text(text)
    local node = { _type = "TEXT", 
                   _parent = self.current, 
                   _text = text
                 }
    table.insert(self.current._children, node)
end

---Parses a comment tag.
-- @param text comment text
function dom:comment(text)
    if self.options.commentNode then
        local node = { _type = "COMMENT", 
                       _parent = self.current, 
                       _text = text 
                     }
        table.insert(self.current._children, node)
    end
end

--- Parses a XML processing instruction (PI) tag
-- @param tag a {name, attrs} table
-- where name is the name of the tag and attrs 
-- is a table containing the atributtes of the tag
function dom:pi(tag)
    if self.options.piNode then
        local node = { _type = "PI", 
                       _name = tag.name,
                       _attr = tag.attrs, 
                       _parent = self.current 
                     } 
        table.insert(self.current._children, node)
    end
end

---Parse the XML declaration line (the line that indicates the XML version).
-- @param tag a {name, attrs} table
-- where name is the name of the tag and attrs 
-- is a table containing the atributtes of the tag
function dom:decl(tag)
    if self.options.declNode then
        local node = { _type = "DECL", 
                    _name = tag.name,
                    _attr = tag.attrs, 
                    _parent = self.current 
                    }
        table.insert(self.current._children, node)
    end
end

---Parses a DTD tag.
-- @param tag a {name, attrs} table
-- where name is the name of the tag and attrs 
-- is a table containing the atributtes of the tag
function dom:dtd(tag)
    if self.options.dtdNode then
        local node = { _type = "DTD", 
                       _name = tag.name,
                       _attr = tag.attrs, 
                       _parent = self.current 
                     }
        table.insert(self.current._children, node)
    end
end

---Parses CDATA tag content.
dom.cdata = dom.text
return dom
