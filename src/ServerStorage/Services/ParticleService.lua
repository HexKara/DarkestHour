local Players = game:GetService("Players")
local Knit = require(game:GetService("ReplicatedStorage").Common.Knit)

local ParticleService = Knit.CreateService {
    Name = "ParticleService";
    Client = {};
}

local STANDARD_NAME = "Aura"

function ParticleService:KnitStart()
    self.sessionParticles = {} 

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            if self.sessionParticles[player] then
                self:SetParticles(player)
            end
        end)
    end)
end

function ParticleService:DeleteParticles(player)
    if not player.Character then return end

    self.sessionParticles[player] = nil   

    local HumanoidRootPart = player.character.Humanoid.HumanoidRootPart

    if HumanoidRootPart:FindFirstChild(STANDARD_NAME) then
        HumanoidRootPart:FindFirstChild(STANDARD_NAME):Destroy()
    end
end

function ParticleService:SetParticles(player, name)
    self:DeleteParticles(player)

    self.sessionParticles[player] = name

	local Effect = game.ServerStorage.Effects:WaitForChild(self.sessionParticles[player]):Clone() 
	
	Effect.Parent = player.character.Humanoid.HumanoidRootPart
	Effect.Name = STANDARD_NAME
end

return ParticleService
