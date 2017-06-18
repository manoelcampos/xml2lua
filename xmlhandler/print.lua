---Handler to generate a simple event trace which 
--outputs messages to the terminal during the XML
--parsing, usually for debugging purposes.
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

module "xmlhandler/print"

function starttag(self, t, a, s, e) 
    io.write("Start    : "..t.."\n") 
    if a then 
        for k,v in pairs(a) do 
            io.write(string.format(" + %s='%s'\n",k,v))
        end 
    end
end

function endtag(self, t, s, e) 
    io.write("End      : "..t.."\n") 
end

function text(self, t, s, e)
    io.write("Text     : "..t.."\n") 
end

function cdata(self, t, s, e)
    io.write("CDATA    : "..t.."\n") 
end

function comment(self, t, s, e)
    io.write("Comment  : "..t.."\n") 
end

function dtd(self, t, a, s, e)     
    io.write("DTD      : "..t.."\n") 
    if a then 
        for k,v in pairs(a) do 
            io.write(string.format(" + %s='%s'\n",k,v))
        end 
    end
end

function pi(self, t, a, s, e) 
    io.write("PI       : "..t.."\n")
    if a then 
        for k,v in pairs(a) do 
            io. write(string.format(" + %s='%s'\n",k,v))
        end 
    end
end

function decl(self, t, a, s, e) 
    io.write("XML Decl : "..t.."\n")
    if a then 
        for k,v in pairs(a) do 
            io.write(string.format(" + %s='%s'\n",k,v))
        end 
    end
end