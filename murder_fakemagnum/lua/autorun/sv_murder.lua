if GAMEMODE_NAME == "murder" or "Murder" then
	hook.Add("PlayerLoadout", "GiveFakeMagnum", function(ply)
		if ply:GetMurderer() then
			ply:Give("weapon_mu_fakemagnum")
		end
	end)
end