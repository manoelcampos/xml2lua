----
--      Handler to generate a DOM-like node tree structure with 
--      a single ROOT node parent - each node is a table comprising 
--      fields below.
--  
--      node = { _name = <Element Name>,
--              _type = ROOT|ELEMENT|TEXT|COMMENT|PI|DECL|DTD,
--              _attr = { Node attributes - see callback API },
--              _parent = <Parent Node>
--              _children = { List of child nodes - ROOT/NODE only }
--            }
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

local _G, print, string, table, pairs, type, tostring, tonumber, error, io
      = 
      _G, print, string, table, pairs, type, tostring, tonumber, error, io

module "xmlhandler/dom"

options = {commentNode=1, piNode=1, dtdNode=1, declNode=1}
root = { _children = {n=0}, _type = "ROOT" }
current = root

function starttag(self, t, a)
        local node = { _type = 'ELEMENT', 
                        _name = t, 
                        _attr = a, 
                        _parent = self.current, 
                        _children = {n=0} }
        table.insert(self.current._children,node)
        self.current = node
end

function endtag(self, t, s)
        if t ~= self.current._name then
        error("XML Error - Unmatched Tag ["..s..":"..t.."]\n")
        end
        self.current = self.current._parent
end

function text(self, t)
        local node = { _type = "TEXT", 
                        _parent = self.current, 
                        _text = t }
        table.insert(self.current._children,node)
end

function comment(self, t)
        if self.options.commentNode then
        local node = { _type = "COMMENT", 
                        _parent = self.current, 
                        _text = t }
        table.insert(self.current._children,node)
        end
end

function pi(self, t, a)
        if self.options.piNode then
        local node = { _type = "PI", 
                        _name = t,
                        _attr = a, 
                        _parent = self.current } 
        table.insert(self.current._children,node)
        end
end

function decl(self, t, a)
        if self.options.declNode then
        local node = { _type = "DECL", 
                        _name = t,
                        _attr = a, 
                        _parent = self.current }
        table.insert(self.current._children,node)
        end
end

function dtd(self, t, a)
        if self.options.dtdNode then
        local node = { _type = "DTD", 
                        _name = t,
                        _attr = a, 
                        _parent = self.current }
        table.insert(self.current._children,node)
        end
end

cdata = text
