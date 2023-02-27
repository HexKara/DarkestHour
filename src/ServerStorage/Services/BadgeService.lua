local Player = game:GetService("Players")
local BadgeService = game:GetService("BadgeService")
local Knit = require(game:GetService("ReplicatedStorage").Common.Knit)

local BadgeService = Knit.CreateService {
    Name = "BadgeService";
    Client = {};
}

local BADGE_ID = 2129329246

function BadgeService:KnitStart()
    Player.PlayerAdded:Connect(function(player)
	    BadgeService:AwardBadge(player.UserId, BADGE_ID)
    end)
end

function BadgeService:KnitInit()
    
end

return BadgeService
