local local_version = "1.0"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/m0nsterJ/Aimware-LUAs/main/Local%20Scope%20Transparency/version.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/m0nsterJ/Aimware-LUAs/main/Local%20Scope%20Transparency/LocalTransparency.lua"

if local_version ~= tostring(github_version) then
    print("Now updating " ..local_script_name)
    file.Delete(local_script_name)
    print("Successfully deleted old version of " ..local_script_name)
    file.Write(local_script_name, http.Get(github_source_url))
    local_version = github_version
    print("Successfully updated " ..local_script_name)
---@diagnostic disable-next-line: undefined-global
    UnloadScript(local_script_name)
end

---@diagnostic disable: redundant-parameter
local gui_local_ref = gui.Reference("visuals", "chams", "local")
local gui_local_slider = gui.Slider(gui_local_ref, "esp.chams.local.scoped", "Scope Transparency", 255, 0, 255, 1)
gui_local_slider:SetPosX(0)
gui_local_slider:SetPosY(50)

local r_1, g_1, b_1, a_1 = gui.GetValue("esp.chams.local.visible.clr")
local r_2, g_2, b_2, a_2 = gui.GetValue("esp.chams.local.occluded.clr")
local r_3, g_3, b_3, a_3 = gui.GetValue("esp.chams.local.overlay.wireframe")

local function local_transparency()

    local local_player = entities.GetLocalPlayer()
    if not local_player ~= nil and not local_player:IsAlive() then
        return
    end

    if not gui.GetValue("esp.world.thirdperson") then
        return
    end

    local scoped = local_player:GetPropBool("m_bIsScoped")

    gui.SetValue("esp.chams.local.visible.clr", r_1, g_1, b_1, a_1)
    gui.SetValue("esp.chams.local.occluded.clr", r_2, g_2, b_2, a_2)
    gui.SetValue("esp.chams.local.overlay.wireframe", r_3, g_3, b_3, a_3)

    if scoped then
        gui.SetValue("esp.chams.local.visible.clr", r_1, g_1, b_1, gui_local_slider:GetValue())
        gui.SetValue("esp.chams.local.occluded.clr", r_2, g_2, b_2, gui_local_slider:GetValue())
        gui.SetValue("esp.chams.local.overlay.wireframe", r_3, g_3, b_3, gui_local_slider:GetValue())
    end
end
callbacks.Register("Draw", local_transparency)