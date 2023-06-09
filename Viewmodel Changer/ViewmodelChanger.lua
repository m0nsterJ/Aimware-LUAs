local local_version = "1.0"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/m0nsterJ/Aimware-LUAs/main/Viewmodel%20Changer/version.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/m0nsterJ/Aimware-LUAs/main/Viewmodel%20Changer/ViewmodelChanger.lua"

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

local vis_ref = gui.Reference("Visuals", "Other")
local viewmodel_changer_box = gui.Groupbox(vis_ref, "Viewmodel Changer", 15, 420, 297, 250)
local viewmodel_check = gui.Checkbox(viewmodel_changer_box, "viewmodel", "Viewmodel Changer", false)
viewmodel_check:SetDescription("Enable Viewmodel Changer.")

local viewmodel_fov_slid = gui.Slider(viewmodel_changer_box, "viewmodel.fov", "FOV", tonumber(client.GetConVar("viewmodel_fov"), 10), 54, 150, 1)
local viewmodel_x_slid = gui.Slider(viewmodel_changer_box, "viewmodel.x", "X Axis", tonumber(client.GetConVar("viewmodel_offset_x"), 10), -50, 50, 0.5)
local viewmodel_y_slid = gui.Slider(viewmodel_changer_box, "viewmodel.y", "Y Axis", tonumber(client.GetConVar("viewmodel_offset_y"), 10), -50, 50, 0.5)
local viewmodel_z_slid = gui.Slider(viewmodel_changer_box, "viewmodel.z", "Z Axis", tonumber(client.GetConVar("viewmodel_offset_z"), 10), -50, 50, 0.5)

local viewmodel =
{
{cvar_ref = "viewmodel_fov", gui_value = viewmodel_fov_slid, cache = 0};
{cvar_ref = "viewmodel_offset_x", gui_value = viewmodel_x_slid, cache = 0};
{cvar_ref = "viewmodel_offset_y", gui_value = viewmodel_y_slid, cache = 0};
{cvar_ref = "viewmodel_offset_z", gui_value = viewmodel_z_slid, cache = 0};
}

local function vmodel_changer()

    if viewmodel_check:GetValue() then
        for i = 1, #viewmodel do
            local viewmodel_values = viewmodel[i].gui_value:GetValue()
            if viewmodel[i].cache ~= viewmodel_values then

                client.SetConVar(viewmodel[i].cvar_ref, viewmodel_values, true)
                viewmodel[i].cache = viewmodel_values
            end
        end
    end
end

callbacks.Register("CreateMove", vmodel_changer)