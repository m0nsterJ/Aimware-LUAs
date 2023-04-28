local local_version = "1.1"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/m0nsterJ/Aimware-LUAs/main/Freestanding/version.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/m0nsterJ/Aimware-LUAs/main/Freestanding/Freestanding.lua"

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

local freestand_check_b = gui.Checkbox((gui.Reference("Ragebot", "Anti-Aim", "Condition")), "freestand_check_b", "Freestand", false)
freestand_check_b:SetDescription("Hide your head behind edges.")

local antiaim_edges =
{
    "rbot.antiaim.left";
    "rbot.antiaim.left.rotation";
    "rbot.antiaim.right";
    "rbot.antiaim.right.rotation";
}

local at_edge_state
local at_edge_cache
local local_player
local cached = false
local cache = { }
local edge_aa_values = { }

local function freestand()

    local_player = entities.GetLocalPlayer()

    if not local_player ~= nil and not local_player:IsAlive() then
        return
    end

    if not cached then
        if gui.GetValue("rbot.master") then
            cache = {gui.GetValue(antiaim_edges[1]), gui.GetValue(antiaim_edges[2]), gui.GetValue(antiaim_edges[3]), gui.GetValue(antiaim_edges[4])}
            at_edge_cache = gui.GetValue("rbot.antiaim.condition.autodir.edges")
            cached = true
        end
    end

    if cached then
        at_edge_state = at_edge_cache
        edge_aa_values = cache

        if freestand_check_b:GetValue() then
            at_edge_state = true
            edge_aa_values = {90; 58; -90; 58}
        end

        for i = 1, #antiaim_edges do
            if gui.GetValue(antiaim_edges[i]) ~= edge_aa_values[i] then
                gui.SetValue("rbot.antiaim.condition.autodir.edges", at_edge_state)
                gui.SetValue(antiaim_edges[i], edge_aa_values[i])
            end
        end
    end
end
callbacks.Register("CreateMove", freestand)