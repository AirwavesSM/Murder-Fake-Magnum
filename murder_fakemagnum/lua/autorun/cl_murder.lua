HaloRenderFakeMagnum = CreateClientConVar( "mu_halo_fakemagnum", 1, true, true )

hook.Add("PreDrawMurderHalos", "DrawHalo", function(Add)
	local client = LocalPlayer()
	local halos = {}
	if GAMEMODE_NAME == "murder" then
		if IsValid(client) && client:Alive() && GAMEMODE.HaloRender:GetBool() then
			if HaloRenderFakeMagnum:GetBool() then
				for k, v in ipairs(ents.FindByClass("weapon_mu_fakemagnum")) do
					if !IsValid(v.Owner) then
						table.insert(halos, {ent = v, color = 1})
					end
				end
			end
		end
	Add(halos, {Color(0, 0, 255)}, 5, 5, 5, true, false)
	end
end)
