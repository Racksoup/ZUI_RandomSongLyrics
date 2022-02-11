RSL = LibStub("AceAddon-3.0"):NewAddon("ZUI_RandomSongLyrics", "AceConsole-3.0", "AceEvent-3.0", "AceSerializer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ZUI_RandomSongLyricsLocale")
local RSL_GUI = LibStub("AceGUI-3.0")

local defaults = {
    realm = {

    },
}

SLASH_RESETRSLDB1 = "/rsl-re"
SLASH_ADDRSLDB1 = "/rsl-add"
SLASH_PLAYRSL1 = "/rsl"

SlashCmdList["RESETRSLDB"] = function()
    RSL.db:ResetDB()
end

SlashCmdList["ADDRSLDB"] = function()
    RSL:CreateInputFrame()
end

SlashCmdList["PLAYRSL"] = function()
    SendChatMessage("HELLO", "SAY", GetDefaultLanguage("player"))
end

function RSL:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("ZUI_LickAndTickleDB", defaults, true)
end

function RSL:OnEnable()
    
end

function RSL:OnDisable()
    
end

function RSL:CreateInputFrame()
    local frame = RSL_GUI:Create("Frame")
    frame:SetPoint("CENTER", 0, -90)
    frame:SetWidth(400)
    frame:SetHeight(300)
    frame:SetTitle("Add Song Lyrics")
    frame:SetLayout("Flow")
    local inputBox = RSL_GUI:Create("MultiLineEditBox")
    inputBox:SetFullHeight(true)
    inputBox:SetFullWidth(true)
    frame:AddChild(addButton)
    frame:AddChild(inputBox)
end 