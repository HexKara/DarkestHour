local playerSerives = {}

local datastoreService = game:GetService("DataStoreService")
local datastore = datastoreService:GetDataStore("PlayerData")

local function SetLeaderstats(player)
    local data = datastore:GetAsync(player.UserId)
    if data then
        for i,v in pairs(data) do
            player.leaderstats[i].Value = v
        end
    end
end

local function AddLeaderstats(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player
    SetLeaderstats(player)
end

local function GetLeaderstats(player)
    
end

game.Players.PlayerAdded:Connect(function(player)
    AddLeaderstats(player)
    
end)

return playerSerives