LootNeed = CreateConVar("mu_fakemagnum_lootneed", 2, FCVAR_ARCHIVE + FCVAR_NOTIFY, "it is necessary to collect loot to get a fake magnum (max 15)",0,15)
MultiplierOn = CreateConVar("mu_fakemagnum_lootneed_multiplier", 1, FCVAR_ARCHIVE + FCVAR_NOTIFY, "Will a weapon be issued for every X loot specified by the ConCommand 'mu_fakemagnum_lootneed' (1 - yes, 0 - no)",0,1)
StartGiveRole = CreateConVar("mu_fakemagnum_giveonstartrole", "mur", FCVAR_ARCHIVE + FCVAR_NOTIFY, "Who to give the magnum to at the beginning of the round ('mur' - murder, 'bys' - random innocent, 'all' - murder and random innocent, 'nil' - nobody)")
AutoSelect = CreateConVar("mu_fakemagnum_autoselect", 1, FCVAR_ARCHIVE + FCVAR_NOTIFY, "When receiving a fake magnum, will it be automatically selected (1 - yes, 0 - no)",0,1)
CanPickup = CreateConVar("mu_fakemagnum_canpickup", "all", FCVAR_ARCHIVE + FCVAR_NOTIFY, "Who can collect for clues/get at the beginning of the round/pick up a fake magnum from the ground ('mur' - murder, 'bys' - innocents, 'all' - murder and innocents, 'nil' - nobody)")

hook.Add("PlayerLoadout", "FakeMagmumLoadout", function(ply)
    if GAMEMODE_NAME != "murder" then return end

	local role = StartGiveRole:GetString()
	local murder = ply:GetMurderer()

	if (!murder and role == "bys") or role == "all" then
    	local noobs = {}
		timer.Simple(0.1, function()
    		for _, player in ipairs(team.GetPlayers(2)) do
        		if !player:GetMurderer() and !player:HasWeapon("weapon_mu_magnum") and #player:GetWeapons() == 1 and player:GetWeapons()[1]:GetClass() == "weapon_mu_hands" then
						table.insert(noobs, player)
					break
        		end
    		end

    		local fakemagnum = noobs[math.random(#noobs)]
			if IsValid(fakemagnum) then
				fakemagnum:Give("weapon_mu_fakemagnum")
				fakemagnum:SelectWeapon("weapon_mu_hands")
			end

			table.remove(noobs)
		end)
	end

    if murder and (role == "mur" or role == "all") then
        ply:Give("weapon_mu_fakemagnum")
        ply:SelectWeapon("weapon_mu_hands")
    end

    if GAMEMODE:GetRound() == 0 then
        ply:Give("weapon_mu_fakemagnum")
		ply:SelectWeapon("weapon_mu_hands")
    end
end)

local function giveFakeMagnum(ply)
	if ply:HasWeapon("weapon_mu_fakemagnum") then
		ply:DropWeapon(ply:GetWeapon("weapon_mu_fakemagnum"))
	end
		ply:Give("weapon_mu_fakemagnum")
	if AutoSelect:GetBool() == true then
		ply:SelectWeapon("weapon_mu_fakemagnum")
	end
end

hook.Add("PlayerCanPickupWeapon", "CanPickupFakeMagnum", function(ply, ent)
	if GAMEMODE_NAME != "murder" then return end

	local role = CanPickup:GetString()
	local murder = ply:GetMurderer()

	if ent:GetClass() == "weapon_mu_fakemagnum" then
		if role == "nil" or (role == "mur" and !murder) or (role == "bys" and murder) then
			return false
		end

		if ply:GetTKer() then
			if ply.TempGiveMagnum then
				ply.TempGiveMagnum = nil
				return true
			end
			return false
		end
	end
end)

hook.Add("PlayerPickupLoot", "LootGivingFakeMagnum", function(ply)
	if GAMEMODE_NAME != "murder" then return end

	local loot = LootNeed:GetInt()

	if loot != 0 then
		if MultiplierOn:GetBool() == false then
			if ply.LootCollected + 1 == loot then
				giveFakeMagnum(ply)
			end
		else
			if (ply.LootCollected + 1) % loot == 0 then
				giveFakeMagnum(ply)
			end
		end
	end
end)