local local_version = "1.1"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/m0nsterJ/Aimware-LUAs/main/Desync%20Inverter/version.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/m0nsterJ/Aimware-LUAs/main/Desync%20Inverter/DesyncInverter.lua"

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

local multiplier = 1
local inverter_key_b = gui.Keybox((gui.Reference("Ragebot", "Anti-Aim", "Advanced")), "inverter_key_b", "Desync Inverter", 0)

inverter_key_b:SetDescription("Invert your base rotation angle.")

local function inverter()

    local local_player = entities.GetLocalPlayer()
    if not local_player ~= nil and not local_player:IsAlive() then
        return
    end

    if inverter_key_b:GetValue() ~= 0 and input.IsButtonPressed(inverter_key_b:GetValue()) then
        multiplier = -1
    else
        multiplier = 1
    end
    gui.SetValue("rbot.antiaim.base.rotation", gui.GetValue("rbot.antiaim.base.rotation") * multiplier)
end

callbacks.Register("Draw", inverter)