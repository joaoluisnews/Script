local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local RecentAdditions = {
    "Scripts"
}

local Window = Rayfield:CreateWindow({
   Name = "Sun Hub",
   Icon = 0,
   LoadingTitle = "Launching Sun Hub...",
   LoadingSubtitle = "by iove Lany",
   ShowText = "Sun Hub",
   Theme = "Default",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "sun hub",
      FileName = "sun Hub"
   },
   KeySystem = true,
   KeySettings = {
      Title = "discord:https://discord.gg/ejxVFmATBn",
      Subtitle = "Key System",
      Note = "join discord for Key",
      FileName = "Sun Hub",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

-- ===== COPIAR DISCORD AUTOMATICAMENTE =====
if setclipboard then
    setclipboard("https://discord.gg/ejxVFmATBn")
end
-- ==========================================

local Tabs = {}
local InfoTab = Window:CreateTab("📌 Info")

InfoTab:CreateParagraph({ Title = "👑 Creator", Content = "iove Lany" })

local TotalScriptParagraph = InfoTab:CreateParagraph({
    Title = "📦 Total Scripts",
    Content = "Counting..."
})

InfoTab:CreateParagraph({
    Title = "🆕 Recently Added",
    Content = table.concat(RecentAdditions, "\n")
})

-- Botão manual de copy
InfoTab:CreateButton({
    Name = "🔗 Copy Discord Invite",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/ejxVFmATBn")
        end
        Rayfield:Notify({ Title = "Copied!", Content = "Discord invite copied.", Duration = 3 })
    end
})

Tabs["Universal"] = Window:CreateTab("Universal")

local ScriptCount = 0

-- Função para adicionar scripts
function AddScript(tab, name, url)
    ScriptCount += 1
    if not Tabs[tab] then Tabs[tab] = Window:CreateTab(tab) end
    Tabs[tab]:CreateButton({
        Name = name,
        Callback = function()
            Rayfield:Notify({ Title = "Sun Hub - "..tab, Content = "Running "..name, Duration = 3 })
            loadstring(game:HttpGet(url))()
        end
    })
end

-- ==================== SCRIPTS ====================

-- 99 night in the forest
AddScript("99 night in the forest", "Xenith Hub", "https://api.luarmor.net/files/v4/loaders/d7be76c234d46ce6770101fded39760c.lua")
AddScript("99 night in the forest", "pulse hub", "https://raw.githubusercontent.com/Chavels123/Loader/refs/heads/main/loader.lua")
AddScript("99 night in the forest", "clavnnX", "https://raw.githubusercontent.com/scclav/sc/refs/heads/main/kk")
AddScript("99 night in the forest", "sapphire hub", "https://pastefy.app/z1F9h812/raw")
AddScript("99 night in the forest", "varlox hub", "https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/VexonHub")
AddScript("99 night in the forest", "mad buk", "https://raw.githubusercontent.com/Nobody6969696969/Madbuk/refs/heads/main/loader.lua")

-- grow a garden
AddScript("grow a garden", "zap hub", "https://zaphub.xyz/Exec")
AddScript("grow a garden", "frost hub", "https://init.frostbyte.lol")
AddScript("grow a garden", "Moondiety", "https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader")
AddScript("grow a garden", "forge hub", "https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua")
AddScript("grow a garden", "Xenith hub", "https://api.luarmor.net/files/v4/loaders/d7be76c234d46ce6770101fded39760c.lua")

-- Steal a brainrot
AddScript("Steal a brainrot", "mondiety", "https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader")
AddScript("Steal a brainrot", "koronis", "https://raw.githubusercontent.com/nf-36/Koronis/refs/heads/main/Scripts/hub.lua")
AddScript("Steal a brainrot", "rift", "https://rifton.top/loader.lua")
AddScript("Steal a brainrot", "xenith", "https://api.luarmor.net/files/v4/loaders/d7be76c234d46ce6770101fded39760c.lua")

-- Fisch
AddScript("Fisch", "blackhub", "https://raw.githubusercontent.com/Skibidiking123/Fisch1/refs/heads/main/FischMain")

-- Anime Eternal
AddScript("Anime Eternal", "noir hub", "https://raw.githubusercontent.com/Oproxide/BESTSCRIPTSPOSSIBLE/ref/head/main/the.lua")
AddScript("Anime Eternal", "gehlee", "https://raw.githubusercontent.com/OhhMyGehlee/sh/refs/heads/main/a")
AddScript("Anime Eternal", "nexor hub", "https://raw.githubusercontent.com/NexorHub/Games/refs/heads/main/Universal/Scripts.lua")

-- ink game
AddScript("ink game", "Moondiety", "https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader")
AddScript("ink game", "xenith", "https://api.luarmor.net/files/v4/loaders/d7be76c234d46ce6770101fded39760c.lua")
AddScript("ink game", "lumin hub", "https://lumin-hub.lol/loader.lua")
AddScript("ink game", "meowl", "https://pastefy.app/aydQLtib/raw")

AddScript("Blox fruits", "tsuo hub", "https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts")

AddScript("Anime Eternal", "AI hub", "https://raw.githubusercontent.com/AIHub091/AI-Hub/refs/heads/main/Anime-Eternal/Script.lua")

AddScript("Blade ball", "xera", "https://xerateam-xyz.vercel.app/BladeBall.lua")

AddScript("Universal", "REM", "https://e-vil.com/anbu/rem.lua")

AddScript("Universal", "infinite yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")

AddScript("Universal", "Universal aimbot", "https://raw.githubusercontent.com/agreed69-scripts/open-src-scripts/refs/heads/main/Universal%20Aimbot.lua"

AddScript("Anime Eternal", kennie hub", "https://raw.githubusercontent.com/Kenniel123/Universal-Loader/refs/heads/main/MultiGame"

AddScript("Anime Eternal", "sigma", "https://raw.githubusercontent.com/fpszrxy/sigma/refs/heads/main/Chasesddhub")

AddScript("Anime Eternal", "project madara", "https://raw.githubusercontent.com/IsThisMe01/Project-Madara/refs/heads/main/loader.lua")

AddScript("Anime Eternal", "v3rmVS", "https://raw.githubusercontent.com/v3md4ddy/v3rmVScripts/refs/heads/main/scriptloader.lua")

AddScript("99 night in the forest", "solex", "https://raw.githubusercontent.com/Soldix-Botty/Solex/refs/heads/main/99%20niggas%20kids%20in%20the%20forest")

AddScript("99 night in the forest", "dominus hub", "https://raw.githubusercontent.com/matheusmerigo/Domius/refs/heads/main/Main99Nights.luau")

AddScript("ink game", "vape void", "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/inkgame.lua")

AddScript("fish it", "space hub", "https://raw.githubusercontent.com/ago106/SpaceHub/refs/heads/main/loader.lua")


-- Atualiza contador de scripts
TotalScriptParagraph:Set({
    Title = "📦 Total Scripts",
    Content = tostring(ScriptCount).." scripts loaded."
})
