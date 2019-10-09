function Update_Tai_SupportFrigate(CustomGroup, playerIndex, shipID)
    NoSalvageScuttle(CustomGroup, playerIndex, shipID)
end

function Create_Tai_SupLatchDock(CustomGroup, playerIndex, shipID)
	SobGroup_Create("LatchDockTempGroup"..shipID)
	SobGroup_Create("LatchDockTempGroup")
end

function Update_Tai_SupLatchDock(CustomGroup, playerIndex, shipID)
	if (SobGroup_AreAllInRealSpace(CustomGroup)==1) then
		if (SobGroup_Empty("LatchDockTempGroup"..shipID)==0) then --Exited Hyperspace with ships docked
			if (SobGroup_IsDoingAbility("LatchDockTempGroup"..shipID, AB_Dock)==0) then
				SobGroup_DockSobGroupAndStayDocked("LatchDockTempGroup"..shipID, CustomGroup)
			end
			SobGroup_GetSobGroupDockedWithGroup(CustomGroup, "LatchDockTempGroup")
			if (SobGroup_Count("LatchDockTempGroup")==SobGroup_Count("LatchDockTempGroup"..shipID)) then --All ships docked
				SobGroup_SetHidden( "LatchDockTempGroup"..shipID, 0)
				SobGroup_MakeSelectable("LatchDockTempGroup"..shipID,1)
				SobGroup_Clear("LatchDockTempGroup"..shipID)
			end
			SobGroup_Clear("LatchDockTempGroup")
		elseif(SobGroup_GetROE(CustomGroup)==0)then --At Aggressive ROE, launch all ships
			SobGroup_GetSobGroupDockedWithGroup(CustomGroup, "LatchDockTempGroup"..shipID)
			SobGroup_Launch("LatchDockTempGroup"..shipID, CustomGroup)
			SobGroup_Clear("LatchDockTempGroup"..shipID)
		elseif(SobGroup_GetROE(CustomGroup)==2)then --At Passive ROE, all ships stay docked
			SobGroup_GetSobGroupDockedWithGroup(CustomGroup, "LatchDockTempGroup"..shipID)
			SobGroup_ForceStayDockedIfDocking("LatchDockTempGroup"..shipID)
			SobGroup_Clear("LatchDockTempGroup"..shipID)
		end
	elseif (SobGroup_Empty("LatchDockTempGroup"..shipID)==1) then --Hyperspacing, get all ships docked with
		SobGroup_GetSobGroupDockedWithGroup(CustomGroup, "LatchDockTempGroup"..shipID)
		SobGroup_AbilityActivate(CustomGroup, AB_Lights, 0)
		SobGroup_SetHidden( "LatchDockTempGroup"..shipID, 1)
		SobGroup_MakeSelectable("LatchDockTempGroup"..shipID,0)
	else --Hyperspacing with ships docked
		if (SobGroup_AreAllInHyperspace("LatchDockTempGroup"..shipID)==0)and(SobGroup_CanDoAbility(CustomGroup,AB_Lights)==0) then --Entering Hyperspace
			SobGroup_Despawn("LatchDockTempGroup"..shipID)
		elseif (SobGroup_AreAllInHyperspace("LatchDockTempGroup"..shipID)==1)and(SobGroup_AreAllInHyperspace(CustomGroup)==1) then --All In Hyperspace
			SobGroup_AbilityActivate(CustomGroup, AB_Lights, 1)
		elseif (SobGroup_AreAllInHyperspace(CustomGroup)==0)and(SobGroup_CanDoAbility(CustomGroup,AB_Lights)==1) then --Exiting Hyperspace
			Volume_AddSphere("LatchDockTempVolume", SobGroup_GetPosition(CustomGroup), 0)
			SobGroup_Spawn("LatchDockTempGroup"..shipID, "LatchDockTempVolume")
			Volume_Delete("LatchDockTempVolume")
		end
	end
end

function Destroy_Tai_SupLatchDock(CustomGroup, playerIndex, shipID)
	if (SobGroup_Empty("LatchDockTempGroup"..shipID)==0) then
		SobGroup_MakeSelectable("LatchDockTempGroup"..shipID,1)
		SobGroup_SetHidden( "LatchDockTempGroup"..shipID, 0)
		SobGroup_Clear("LatchDockTempGroup"..shipID)
	end
end