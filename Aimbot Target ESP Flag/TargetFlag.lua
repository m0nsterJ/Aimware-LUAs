local local_version = "1.0"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/m0nsterJ/Aimware-LUAs/main/Aimbot%20Target%20ESP%20Flag/version.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/m0nsterJ/Aimware-LUAs/main/Aimbot%20Target%20ESP%20Flag/TargetFlag.lua"

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

local cache =
{
    current_target = nil;
}

local function UpdateTarget(entity)
    if entity:GetName() then
        cache.current_target = entity;
    else
        cache.current_target = nil;
    end
end

local function DrawESP(builder)
    local builderentity = builder:GetEntity();
    if cache.current_target and builderentity:GetIndex() == cache.current_target:GetIndex() then
        builder:Color(255, 0, 0, 255);
        builder:AddTextRight("T");
    else
        builder:Color(0, 0, 0, 0);
        builder:AddTextRight("");
    end
end

callbacks.Register("AimbotTarget", UpdateTarget)
callbacks.Register("DrawESP", DrawESP)