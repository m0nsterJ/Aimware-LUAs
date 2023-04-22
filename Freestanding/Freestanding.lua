local freestand_check_b = gui.Checkbox((gui.Reference("Ragebot", "Anti-Aim", "Condition")), "freestand_check_b", "Freestand", false)
local freestand_key_b = gui.Keybox((gui.Reference("Ragebot", "Anti-Aim", "Condition")), "freestand_key_b", "Freestand Key", 0)
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
local cached = false
local should_exec = false
local cache = { }
local edge_aa_values = { }

local function freestand()
    local lp = entities.GetLocalPlayer()

    if lp:IsAlive() and lp ~= nil then

        if freestand_check_b:GetValue() then
            if not cached then
                cache = {gui.GetValue(antiaim_edges[1]), gui.GetValue(antiaim_edges[2]), gui.GetValue(antiaim_edges[3]), gui.GetValue(antiaim_edges[4])}
                at_edge_cache = gui.GetValue("rbot.antiaim.condition.autodir.edges")
                cached = true
            end
        end

        if freestand_key_b:GetValue() ~= 0 then
            if input.IsButtonDown(freestand_key_b:GetValue()) then
                at_edge_state = true
                edge_aa_values = {90; 58; -90; 58}
            else
                at_edge_state = at_edge_cache
                edge_aa_values = cache
            end
        end

        if cached then
            for i = 1, #antiaim_edges do
                if gui.GetValue(antiaim_edges[i]) ~= edge_aa_values[i] then
                    gui.SetValue("rbot.antiaim.condition.autodir.edges", at_edge_state)
                    gui.SetValue(antiaim_edges[i], edge_aa_values[i])
                end
            end
        end
    end
end
callbacks.Register("CreateMove", freestand)