#!/usr/bin/env lua

---Sample application showing how to convert a Lua Table to an XML representation
--@author @DusanNikolicc11 

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

--[[
Expected output:
<WindowElement xmins="http://windows. Ibl.gov" xmins:xsi="http//www.w3.org/2001/X MLSchema— instance” xsi:schemaLocation="http://windows. bl gov/BSDF—v 1.4.xsd">
<Optical>
    <Layer>
        <Material>
            <Name>Perfect Diffuser</Name>
            <Manufacturer>ACME Surfaces</Manufacturer>
            <Thickness unit="Meter">0.150</Thickness>
            <Width unit="Meter">1.000</Width>
            <Height unit="Meter">1.000</Height>
        </Material>
        <DataDefinition>
            <IncidentDataStructure>TensorTree3</IncidentDalaStructure>
        </DataDefinition>
        <WavelengthData>
            <LayerNumber>System</LayerNumber>
            <Wavelength unit="Integral">Visible</Wavelength>
                <SourceSpectrum>CIE Illuminant D65 Inm.ssp</SourceSpectrum>
                <DetectorSpectrum>ASTM E308 1931 Y.dsp</DetectorSpectrum>
                <WavelengthDataBlock>
                    <WavelengthDataDirection>Reflection Back</WavelengthDataDirection>
                    <AngleBasis>LBNL/Shirkey—Chiu</AngleBasis>
                    <ScatteringDataType>BRDF</ScatteringDataType>
                    <ScatteringData>{ 0.318309886 }</ScatteringData>
                </WavelengthDataBlock>
            </WavelengthData>
        </Layer>
    </Optical>
</WindowElement>
]]
