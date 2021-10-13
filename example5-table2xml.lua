#!/usr/bin/env lua

---Sample application showing how to convert a Lua Table to an XML representation
--@author Manoel Campos da Silva Filho - http://manoelcampos.com

local xml2lua = require("xml2lua")
print("xml2lua v" .. xml2lua._VERSION.."\n")

local body = {
    WindowElement = {
        _attr = {
            ["xmlns"] = "http://windows.lbl.gov",
            ["xmlns:xsi"] = "http://www.w3.org/2001/XMLSchema-instance",
            ["xsi:schemaLocation"] = "http://windows.lbl.gov/BSDF-v1.4.xsd"
        },
        Optical = {
            Layer = {
                Material = {
                    Name = "Perfect Diffuser",
                    Manufacturer = "ACME Surfaces",
                    Thickness = {
                        _attr = { unit = "Meter", },
                        0.150
                    },
                    Width = {
                        _attr = { unit = "Meter", },
                        1.000
                    },
                    Height = {
                        _attr = { unit = "Meter", },
                        1.000
                    }
                },
                DataDefinition = {
                    IncidentDataStructure = "TensorTree3"
                },
                WavelengthData = {
                    LayerNumber = "System",
                    Wavelength = {
                        _attr = { ["type"] = "Integral" },
                        "Visible",
                    },
                    SourceSpectrum = "CIE Illuminati D65 Inn.ssp",
                    DetectorSpectrum = "ASTM E308 1931 Y.dsp",
                    WavelengthDataBlock = {
                        WavelengthDataDirection = "Reflection Back",
                        AngleBasis = "LBNL/Shirley-Chiu",
                        ScatteringDataType = "BRDF",
                        ScatteringData = "{ 0.318309886 }"
                    }
                },
            }
        }
    }
}

print("Window element Table\n")
xml2lua.printable(body)
print("\n------------------------------------------------------\n")

print("XML Representation\n")
print(xml2lua.toXml(body))
