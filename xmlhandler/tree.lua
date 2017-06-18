---Handler to generate a lua table from an XML content string.
-- It is a simplified handler which attempts 
-- to generate a more 'natural' table based structure which
-- supports many common XML formats. 
-- 
-- The XML tree structure is mapped directly into a recursive
-- table structure with node names as keys and child elements
-- as either a table of values or directly as a string value
-- for text. Where there is only a single child element this
-- is inserted as a named key - if there are multiple
-- elements these are inserted as a vector (in some cases it
-- may be preferable to always insert elements as a vector
-- which can be specified on a per element basis in the
-- options).  Attributes are inserted as a child element with
-- a key of '_attr'. 
-- 
-- Only Tag/Text & CDATA elements are processed - all others
-- are ignored.
-- 
-- This format has some limitations - primarily
--  
-- * Mixed-Content behaves unpredictably - the relationship 
--   between text elements and embedded tags is lost and 
--   multiple levels of mixed content does not work
-- * If a leaf element has both a text element and attributes
--   then the text must be accessed through a vector (to
--   provide a container for the attribute)
--
-- In general however this format is relatively useful. 
--
-- It is much easier to understand by running some test
-- data through 'textxml.lua -simpletree' than to read this)
--
-- Options
-- =======
--    options.noReduce = { <tag> = bool,.. }
--        - Nodes not to reduce children vector even if only 
--          one child
--
--  License:
--  ========
--
--  This code is freely distributable under the terms of the [MIT license](LICENSE).
--
--@author Paul Chakravarti (paulc@passtheaardvark.com)
--@author Manoel Campos da Silva Filho

local _G, print, string, table, pairs, type, tostring, tonumber, error, io
      = 
      _G, print, string, table, pairs, type, tostring, tonumber, error, io

module "xmlhandler/tree"

root = {}     
stack = {root; n=1}
options = {noreduce = {}}

--Gets the first key of a table
--@param tb table to get its first key
--@return the table's first key, nil if the table is empty 
--or the given parameter if it isn't a table
local function getFirstKey(tb)
   if type(tb) == "table" then
      for k, v in pairs(tb) do
          return k
      end

      return nil
   end

   return tb
end

function reduce(self, node, key, parent)
    -- Recursively remove redundant vectors for nodes
    -- with single child elements
    for k,v in pairs(node) do
        if type(v) == 'table' then
            self:reduce(v,k,node)
        end
    end
    if #node == 1 and not self.options.noreduce[key] and 
        node._attr == nil then
        parent[key] = node[1]
    else
        node.n = nil
    end
end
    
---Parses a start tag
--@param t Table that represents a XML tag
--@param a Attributes table (_attr)
function starttag(self, t, a)
    local node = {}
    if self.parseAttributes == true then
        node._attr=a
    end
    
    local current = self.stack[#self.stack]
    if current[t] then
        table.insert(current[t],node)
    else
        current[t] = {node;n=1}
    end
    table.insert(self.stack,node)
end

---Parses an end tag
--@param t Tag name
function endtag(self, t, s)
    --Tabela que representa a tag atualmente sendo processada
    local current = self.stack[#self.stack]
    --Tabela que representa a tag na qual a tag
    --atual está contida.
    local prev = self.stack[#self.stack-1]
    if not prev[t] then
        error("XML Error - Unmatched Tag ["..s..":"..t.."]\n")
    end
    if prev == self.root then
        -- Once parsing complete recursively reduce tree
        self:reduce(prev,nil,nil)
    end
    
    local firstKey = getFirstKey(current)
    --Se a primeira chave da tabela que representa
    --a tag  atual não possui nenhum elemento,
    --é porque não há nenhum valor associado à tag
    -- (como nos casos de tags automaticamente fechadas como <senha />).
    --Assim, atribui uma string vazia a mesma para
    --que seja retornado vazio no lugar da tag e não
    --uma tabela. Retornando uma string vazia
    --simplifica para as aplicações NCLua
    --para imprimir tal valor.
    if firstKey == nil then
        current[t] = ""
        prev[t] = ""
    end
        
    table.remove(self.stack)
end

function text(self, t)
    local current = self.stack[#self.stack]
    table.insert(current,t)
end

cdata = text