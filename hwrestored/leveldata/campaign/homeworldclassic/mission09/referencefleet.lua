-- reference fleet for this level

Fleet = 
{
    -- these are the ships we expect the player to have:
     {
        Type = "Kus_Mothership",
        Number = 1,
    },
    {
        Type = "Kus_ResearchShip",
        Number = 10,
    },
    {
        Type = "Kus_ResourceCollector",
        Number = 40,
    },
    {
        Type = "Kus_SalvageCorvette",
        Number = 40,
    }, 
    {
        Type = "Kus_Interceptor",
        Number =120,
    },
    {
        Type = "Kus_LightCorvette",
        Number = 50,
    },
    {
        Type = "Kus_HeavyCorvette",
        Number = 90,
    },
    {
        Type = "Kus_AttackBomber",
        Number = 140,
    },
    {
        Type = "Kus_AssaultFrigate",
        Number = 50,
    },
    {
        Type = "Kus_IonCannonFrigate",
        Number = 40,
    },
    {
        Type = "Kus_Destroyer",
        Number = 20,
    },
}

-- and we think they should have this much money:
RUs = 200000

--Load expanded options
dofilepath("data:scripts/playerspatch/playerspatch_sp_util.lua")
RefMissionDifficultyScale = GetMissionDifficultyScale()

multiplierForExtraShips = RefMissionDifficultyScale
multiplierForExtraRU = RefMissionDifficultyScale