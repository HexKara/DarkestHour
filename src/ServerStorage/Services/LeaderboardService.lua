local Players = game:GetService("Players")
local Knit = require(game:GetService("ReplicatedStorage").Common.Knit)

local LeaderboardService = Knit.CreateService {
    Name = "LeaderboardService";
    Client = {};
}


function LeaderboardService:KnitStart()
    Players.PlayerAdded:Connect(function(player)
        local leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player
        
        local seconds = Instance.new("IntValue")
        seconds.Name = "Seconds"
        seconds.Value = 0
        seconds.Parent = player
        
        local minutes = Instance.new("IntValue")
        minutes.Name = "Level"
        minutes.Value = 0
        minutes.Parent = leaderstats
    end)
end


function LeaderboardService:KnitInit()
    
end


return LeaderboardService
