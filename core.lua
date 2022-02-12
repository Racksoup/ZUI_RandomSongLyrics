RSL = LibStub("AceAddon-3.0"):NewAddon("ZUI_RandomSongLyrics")
local L = LibStub("AceLocale-3.0"):GetLocale("ZUI_RandomSongLyricsLocale")
local RSL_GUI = LibStub("AceGUI-3.0")

local defaults = {
    realm = {
        list = {}
    },
}

SLASH_DELETEALL1 = "/rsl-deleteall"
SLASH_REMOVE1 = "/rsl-del"
SLASH_ADDRSLDB1 = "/rsl-add"
SLASH_PLAYRSL1 = "/rslp"
SLASH_INFO1 = "/rsl"

SlashCmdList["DELETEALL"] = function()
    RSL.db:ResetDB()
end

SlashCmdList["REMOVE"] = function()
    RSL:CreateRemoveFrame()
    RSL_GUI.removeFrame:Show()
end

SlashCmdList["ADDRSLDB"] = function()
    RSL_GUI.inputFrame:Show()
end

SlashCmdList["PLAYRSL"] = function()
    if (#RSL.db.realm.list ~= 0) then
        local randIndex = math.random(1, #RSL.db.realm.list)
        --print(RSL.db.realm.list[randIndex])
        SendChatMessage(RSL.db.realm.list[randIndex], "SAY", GetDefaultLanguage("player"))
    end
end

SlashCmdList["INFO"] = function()
    print("/rslp - ", L["play random"])
    print("/rsl-add - ", L["add entries"])
    print("/rsl-del - ", L["delete one entry"])
    print("/rsl-deleteall - ", L["delete all data"])
end

function RSL:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("ZUI_LickAndTickleDB", defaults, true)
    RSL:CreateInputFrame()
end

function RSL:CreateInputFrame()
    if (not RSL_GUI.inputFrame) then
        RSL_GUI.inputFrame = RSL_GUI:Create("Frame")
        local frame = RSL_GUI.inputFrame
        frame:SetPoint("CENTER", 0, -90)
        frame:SetWidth(400)
        frame:SetHeight(300)
        frame:SetLayout("Flow")
        frame:SetTitle(L["Add Song Lyrics"])
        frame:SetStatusText(L["Add Song Lyrics"])
        local inputBox = RSL_GUI:Create("MultiLineEditBox")
        inputBox:SetFullHeight(true)
        inputBox:SetFullWidth(true)
        inputBox:SetCallback("OnEnterPressed", function(text) table.insert(RSL.db.realm.list, inputBox:GetText()) end) 
        frame:AddChild(inputBox)
        frame:Hide()
    end
end 

function RSL:CreateRemoveFrame()
    if(RSL_GUI.removeFrame) then RSL_GUI.removeFrame:Release() end
    RSL_GUI.removeFrame = RSL_GUI:Create("Frame")
    local frame = RSL_GUI.removeFrame
    frame:SetPoint("CENTER", 0, -90)
    frame:SetWidth(700)
    frame:SetHeight(600)
    frame:SetLayout("List")
    frame:SetTitle(L["Add Song Lyrics"])
    frame:SetStatusText(L["Add Song Lyrics"])
    for i, v in ipairs(RSL.db.realm.list) do
        local removeLabel = RSL_GUI:Create("InteractiveLabel")
        removeLabel:SetFullHeight(true)
        removeLabel:SetFullWidth(true)
        removeLabel:SetText(v)
        removeLabel:SetFont("Fonts\\FRIZQT__.TTF", 20, "THINOUTLINE")
        removeLabel:SetCallback("OnClick", function() 
            removeLabel:SetText("")
            table.remove(RSL.db.realm.list, i)
        end)
        frame:AddChild(removeLabel)
    end
    frame:Hide()
end