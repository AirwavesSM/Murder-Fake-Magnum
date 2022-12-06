LootNeed = CreateConVar("mu_fakemagnum_lootneed", 2, FCVAR_ARCHIVE + FCVAR_NOTIFY, "it is necessary to collect loot to get a fake magnum (max 15)",0,15)
MultiplierOn = CreateConVar("mu_fakemagnum_lootneed_multiplier", 1, FCVAR_ARCHIVE + FCVAR_NOTIFY, "Will a weapon be issued for every X loot specified by the ConCommand 'mu_fakemagnum_lootneed' (1 - yes, 0 - no)",0,1)
StartGive = CreateConVar("mu_fakemagnum_giveonstart", 1, FCVAR_ARCHIVE + FCVAR_NOTIFY, "Whether to issue a fake magnum at the beginning of the round (1 - yes, 0 - no)",0,1)
AutoSelect = CreateConVar("mu_fakemagnum_autoselect", 1, FCVAR_ARCHIVE + FCVAR_NOTIFY, "When receiving a fake magnum, will it be automatically selected (1 - yes, 0 - no)",0,1)


hook.Add("PlayerLoadout", "GiveFakeMagnum", function(ply)
	if GAMEMODE_NAME == "murder" then
		if (ply:GetMurderer() and StartGive:GetInt() == 1) or GAMEMODE:GetRound() == 0 then
			ply:Give("weapon_mu_fakemagnum")
		end
	end
end)

local function giveFakeMagnum(ply)
	if ply:HasWeapon("weapon_mu_fakemagnum") then
		ply:DropWeapon(ply:GetWeapon("weapon_mu_fakemagnum"))
	end
		ply:Give("weapon_mu_fakemagnum")
	if AutoSelect:GetInt() == 1 then
		ply:SelectWeapon("weapon_mu_fakemagnum")
	end
end

hook.Add("PlayerPickupLoot", "LootGiving", function(ply)
	print(ply.LootCollected + 1 .." / ".. LootNeed:GetInt())
	if GAMEMODE_NAME == "murder" then
		if ply:GetMurderer() then
			if LootNeed:GetInt() != 0 then
				if MultiplierOn:GetInt() == 0 then
					if ply.LootCollected + 1 == LootNeed:GetInt() then
						giveFakeMagnum(ply)
					end
				else
					if (ply.LootCollected + 1) % LootNeed:GetInt() == 0 then
						giveFakeMagnum(ply)
					end
				end
			end
		end
	end
end)