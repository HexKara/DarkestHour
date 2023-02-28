local playerSerives = {}

local datastoreService = game:GetService("DataStoreService")
local datastore = datastoreService:GetDataStore("PlayerData")

local function SetLeaderstats(player : Player)
    local data = datastore:GetAsync(player.UserId)
    if data then
        for i,v in pairs(data) do
            player.leaderstats[i].Value = v
        end
    end
end

local function AddLeaderstats(player : Player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player
    SetLeaderstats(player) 
end

local function SaveLeaderstats(player : Player)
    local data = {}
    for i,v in pairs(player.leaderstats:GetChildren()) do
        data[v.Name] = v.Value
    end
    datastore:SetAsync(player.UserId, data)
end

game.Players.PlayerAdded:Connect(function(player)
    AddLeaderstats(player)
    
end)

game.Players.PlayerRemoving:Connect(function(player)
    SaveLeaderstats(player)
end)

return playerSerives