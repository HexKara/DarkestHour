local ProximityPromptService = game:GetService("ProximityPromptService")
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

local BoothController = Knit.CreateController { Name = "BoothController" }

function BoothController:KnitStart()
    self.BoothService = Knit.GetService("BoothService")

    ProximityPromptService.PromptTriggered:Connect(function(prompt)
        local boothNumber = prompt:GetAttribute("boothNumber")
        self.BoothService.ClaimBooth:Fire(boothNumber)
    end)
end

function BoothController:KnitInit()
    
end

return BoothController
