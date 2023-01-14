local shop = game.Workspace.Ignored.Shop
local LocalPlayer = game.Players.LocalPlayer
local state = false
local food, p
LocalPlayer:GetMouse().KeyDown:Connect(function(x)
    if x == getgenv().keybind and state == false then
        state = true
        p = LocalPlayer.Character.HumanoidRootPart.CFrame
        food = shop["[Pizza] - $5"]
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(food.Head.Position)
        wait(0.8)
        fireclickdetector(food.ClickDetector)
        food = shop["[Chicken] - $7"]
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(food.Head.Position)
        wait(0.8)
        fireclickdetector(food.ClickDetector)
        food = shop["[Popcorn] - $7"]
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(food.Head.Position)
        wait(0.8)
        fireclickdetector(food.ClickDetector)
        food = shop["[Lettuce] - $5"]
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(food.Head.Position)
        wait(0.8)
        fireclickdetector(food.ClickDetector)
        food = shop["[Hamburger] - $5"]
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(food.Head.Position)
        wait(0.8)
        fireclickdetector(food.ClickDetector)
        food = shop["[Taco] - $4"]
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(food.Head.Position)
        wait(0.8)
        fireclickdetector(food.ClickDetector)
        food = shop["[HotDog] - $8"]
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(food.Head.Position)
        wait(0.8)
        fireclickdetector(food.ClickDetector)
        food = shop["[Meat] - $12"]
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(food.Head.Position)
        wait(0.8)
        fireclickdetector(food.ClickDetector)
        LocalPlayer.Character.HumanoidRootPart.CFrame = p
        state = false
    end
end)
