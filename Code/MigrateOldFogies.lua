----RetirementHomes Copyright (C) 2020 Shrooblord
--Create a button on all Residence Buildings that switches between three states: default vanilla behaviour, Retirement Home (Seniors take priority), or Workhouse (Seniors evicted if a younger person is looking for a home)
--  Heavily hijacked ChoCGi's "Disable Drone Maintenance" script because it did almost everything I needed from a UI / UX perspective, and made for some excellent training wheels.
--  Also took inspiration from SkiRich's "Career A.I." for how to shuffle Colonists around in a sane per-8h basis, while respecting Dome/Passage filters, etc. that the user already had in-place (but not any actual functional code; their LICENSE prevents this -- so all similar code is my own work).

--#region init
--Perform the change: set a flag so that, when the "hourly" tick comes around (see the onMsgs section), we know what to do: to migrate, or not to migrate... that is the question
--  currently just a copy-pasta with a name change. nothing is actually happening here yet
local function SetSeniorAcceptanceState(obj, maintenance)
	obj.maintenance_phase = false
	if maintenance then
		-- re-enable main
		obj.ChoGGi_DisableMaintenance = nil
		-- reset main requests (thanks mk-fg)
		obj:AccumulateMaintenancePoints(0)
		-- and check if building is malfunctioned then call a fix
		if obj.accumulated_maintenance_points == obj.maintenance_threshold_current then
			obj:RequestMaintenance()
		end
	else
		-- disable it
		obj.ChoGGi_DisableMaintenance = true
		-- reset main requests (thanks mk-fg)
		obj:ResetMaintenanceRequests()
	end
end
--#endregion


--#region === *** OnMsg *** === --
--#region HUD
--  currently just a copy-pasta. nothing is actually happening here yet
function OnMsg.ClassesPostprocess()
	local RetAllOfClass = ChoGGi.ComFuncs.RetAllOfClass
	local PopupToggle = ChoGGi.ComFuncs.PopupToggle
	local RetName = ChoGGi.ComFuncs.RetName

--~ 	local XTemplates = XTemplates
--~ 	-- old version cleanup
--~ 	if XTemplates.ipBuilding.ChoGGi_DisableMaintenance then
--~ 		ChoGGi.ComFuncs.RemoveXTemplateSections(XTemplates.ipBuilding[1], "ChoGGi_DisableMaintenance")
--~ 		XTemplates.ipBuilding.ChoGGi_DisableMaintenance = nil
--~ 	end

	ChoGGi.ComFuncs.AddXTemplate("DisableMaintenance", "ipBuilding", {
		__context_of_kind = "Residence",
--~ 		RolloverHint = T(0000000, "<left_click> for menu, <right_click> to toggle selected.")
		OnContextUpdate = function(self, context)
			local name = RetName(context)
			if context.ChoGGi_DisableMaintenance then
				self:SetRolloverText(T{302535920011071, "This <name> will not be maintained.", name = name})
				self:SetTitle(T(302535920011072, "Maintenance Disabled"))
				self:SetIcon("UI/Icons/traits_disapprove.tga")
			else
				self:SetRolloverText(T{302535920011073, "This <name> will be maintained.", name = name})
				self:SetTitle(T(302535920011074, "Maintenance Enabled"))
				self:SetIcon("UI/Icons/traits_approve.tga")
			end
		end,
		func = function(self, context)
			---
			local popup = terminal.desktop.idDisableDroneMaintenanceMenu
			if popup then
				popup:Close()
			else
				local name = RetName(context)
				PopupToggle(self, "idDisableDroneMaintenanceMenu", {
					{
						name = T{302535920011075, "Toggle maintenance on this <name> only.", name = name},
						clicked = function()
							SetSeniorAcceptanceState(context, context.ChoGGi_DisableMaintenance)
						end,
					},
					{
						name = T{302535920011077, "Toggle maintenance on all <name>.", name = name},
						hint = T{302535920011078, "Toggles maintenance on all <name> (all will be set the same as this one).", name = name},
						clicked = function()
							local objs = RetAllOfClass(context.class)
							local toggle = context.ChoGGi_DisableMaintenance
							for i = 1, #objs do
								SetSeniorAcceptanceState(objs[i], toggle)
							end
						end,
					},
					{
						name = T{302535920011563, "Enable maintenance on all <name>.", name = name},
						clicked = function()
							local objs = RetAllOfClass(context.class)
							for i = 1, #objs do
								SetSeniorAcceptanceState(objs[i], true)
							end
						end,
					},
					{
						name = T{302535920011564, "Disable maintenance on all <name>.", name = name},
						clicked = function()
							local objs = RetAllOfClass(context.class)
							for i = 1, #objs do
								SetSeniorAcceptanceState(objs[i], false)
							end
						end,
					},
				}, "left")
			end
			---
		end,
	})

end --OnMsg
--#endregion

--#region hourly-ticks
--...see SkiRich's "Career A.I." as an example...
--#endregion

--#endregion
