local Knit = require(game:GetService("ReplicatedStorage").Common.Knit)

local BoothService = Knit.CreateService {
    Name = "BoothService";
    Client = {
        ClaimBooth = Knit.CreateSignal(),
        EditText = Knit.CreateSignal()
    };
}

function BoothService:KnitStart()
    self.boothOwnership = {}

    self.Client.ClaimBooth:Connect(function(player, boothNumber)
        self.boothOwnership[player] = boothNumber
    end)

    self.Client.EditText:Connect(function(player, text)
        self:EditText(player, text)
    end)
end

function BoothService:EditText(player, text)
    local booth = self:GetPlayerBooth(player)
    
    booth.TextArea.TextLabel.Text = text
end

function BoothService:GetPlayerBooth(player)
    return game.Workspace.Booths:FindFirstChild("Booth" .. self.boothOwnership[player])
end

function BoothService:KnitInit()
    
end

return BoothService
