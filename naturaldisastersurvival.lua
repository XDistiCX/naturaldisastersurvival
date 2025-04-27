-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Window
local Window = Rayfield:CreateWindow({
	Name = "DisticHUB - Natural Disaster Survival v1.0",
	Icon = 0,
	LoadingTitle = "DisticHUB",
	LoadingSubtitle = "by Distic",
	Theme = "Default",
	ConfigurationSaving = {
	   Enabled = true,
	   FolderName = nil,
	   FileName = "Big Hub"
	},
	Discord = {
	   Enabled = false,
	   Invite = "noinvitelink",
	   RememberJoins = true
	},
	KeySystem = false,
	KeySettings = {
	   Title = "DisticHUB",
	   Subtitle = "Key System",
	   Note = "The key is {DCHUB-987654321}",
	   FileName = "Key",
	   SaveKey = true,
	   GrabKeyFromSite = false,
	   Key = {"DCHUB-987654321"}
	}
})

-- Initial Notification
Rayfield:Notify({
	Title = "Distic",
	Content = "Welcome to my world!!!",
	Duration = 6.5,
	Image = 4483362458,
})

-- Create Tabs
local Tab = Window:CreateTab("Natural Disaster Survival", 4483362458)
local TabThe = Window:CreateTab("Theme", 4483362458)
local TabCre = Window:CreateTab("Credits", 4483362458)

-- Create Labels in Credit Tab
local Label = TabCre:CreateLabel("Made by Distic")
local Label2 = TabCre:CreateLabel("Follow me on Instagram @disticx_")

-- Create Theme Buttons
local Button10 = TabThe:CreateButton({
	Name = "Default",
	Callback = function()
	   Window.ModifyTheme("Default")
	end,
})

local Button11 = TabThe:CreateButton({
	Name = "AmberGlow",
	Callback = function()
	   Window.ModifyTheme("AmberGlow")
	end,
})

local Button12 = TabThe:CreateButton({
	Name = "Amethyst",
	Callback = function()
	   Window.ModifyTheme("Amethyst")
	end,
})

local Button13 = TabThe:CreateButton({
	Name = "Bloom",
	Callback = function()
	   Window.ModifyTheme("Bloom")
	end,
})

local Button14 = TabThe:CreateButton({
	Name = "DarkBlue",
	Callback = function()
	   Window.ModifyTheme("DarkBlue")
	end,
})

local Button15 = TabThe:CreateButton({
	Name = "Green",
	Callback = function()
	   Window.ModifyTheme("Green")
	end,
})

local Button16 = TabThe:CreateButton({
	Name = "Light",
	Callback = function()
	   Window.ModifyTheme("Light")
	end,
})

local Button17 = TabThe:CreateButton({
	Name = "Ocean",
	Callback = function()
	   Window.ModifyTheme("Ocean")
	end,
})

local Button18 = TabThe:CreateButton({
	Name = "Serenity",
	Callback = function()
	   Window.ModifyTheme("Serenity")
	end,
})

-- Create Section
local Section = Tab:CreateSection("Main Menu")

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

-- Walkspeed Slider
local walkspeedSlider = Tab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 200},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") and localPlayer.Character.Humanoid.WalkSpeed or 16,
   Flag = "WalkSpeedSlider", -- A flag for saving the config
   Callback = function(Value)
      localPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- Infinite Jump Toggle
local InfiniteJumpEnabled = false
local function resetInfiniteJump()
    InfiniteJumpEnabled = false
    Rayfield:Notify({
        Title = "DistiC",
        Content = "Infinite Jump is inactive. Press the button to reactivate.",
        Duration = 5,
		Image = 4483362458,
    })
end

local InfiniteJumpToggle = Tab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJumpToggle",  -- Unique identifier for the toggle
   Callback = function(Value)
      InfiniteJumpEnabled = Value
      if InfiniteJumpEnabled then
         Rayfield:Notify({
            Title = "DistiC",
            Content = "Infinite Jump is now enabled.",
            Duration = 5,
			Image = 4483362458,
         })
      else
         resetInfiniteJump()
      end
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState("Jumping")
        end
    end
end)

localPlayer.CharacterAdded:Connect(function(newCharacter)
    -- Reset Infinite Jump when the character respawns
    InfiniteJumpEnabled = false
    Rayfield:ModifyToggle("InfiniteJumpToggle", false) -- Reset toggle in UI to off
    resetInfiniteJump()
end)

-- No Fall Damage Toggle
local NoFallDamageEnabled = false
local currentNoFallDamageConnection

local function nofalldamage(chr)
    local root = chr:WaitForChild("HumanoidRootPart")
    if root then
        currentNoFallDamageConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not root.Parent then
                currentNoFallDamageConnection:Disconnect()
            end
            -- Prevent fall damage by setting velocity to zero
            local oldvel = root.AssemblyLinearVelocity
            root.AssemblyLinearVelocity = Vector3.zero
            game:GetService("RunService").RenderStepped:Wait()
            root.AssemblyLinearVelocity = oldvel
        end)
    end
end

local function resetFallDamage(chr)
    -- This function resets the fall damage (removes the No Fall Damage effect)
    if currentNoFallDamageConnection then
        currentNoFallDamageConnection:Disconnect()
        currentNoFallDamageConnection = nil
    end
    -- Optional: You can add any code to restore velocity handling here if required
end

local NoFallDamageToggle = Tab:CreateToggle({
    Name = "No Fall Damage",
    CurrentValue = false,
    Flag = "NoFallDamageToggle",  -- Unique identifier for the toggle
    Callback = function(Value)
        NoFallDamageEnabled = Value

        if NoFallDamageEnabled then
            Rayfield:Notify({
                Title = "DistiC",
                Content = "No Fall Damage is now enabled.",
                Duration = 5,
				Image = 4483362458,
            })

            -- Apply No Fall Damage effect to current character
            local character = localPlayer.Character
            if character then
                nofalldamage(character)
            end
        else
            Rayfield:Notify({
                Title = "DistiC",
                Content = "No Fall Damage is now disabled.",
                Duration = 5,
				Image = 4483362458,
            })

            -- Restore fall damage (reset the connection and allow fall damage again)
            local character = localPlayer.Character
            if character then
                resetFallDamage(character)
            end
        end
    end,
})

-- Listen to when the character is added, to apply No Fall Damage to a new character
localPlayer.CharacterAdded:Connect(function(newCharacter)
    if NoFallDamageEnabled then
        -- Reapply No Fall Damage if enabled and a new character is added
        nofalldamage(newCharacter)
    else
        -- Reset No Fall Damage when a new character is added if disabled
        resetFallDamage(newCharacter)
    end
end)

-- Create Section
local Section2 = Tab:CreateSection("Special Menu")

-- Get Balloon Button and Information
local ballonParagraph = Tab:CreateParagraph({
    Title = "Note:",
    Content = "Please note that the Green Balloon can only be obtained if there is a player currently using it. If the balloon is not available, keep trying and be persistent until you can successfully acquire it. Keep in mind that it may take a few attempts before the balloon appears for you to collect."
})

local getBalloonButton = Tab:CreateButton({
    Name = "Get Green Balloon",
    Callback = function()
        local function createNotif(title, text, icon, duration)
            Rayfield:Notify({
                Title = title,
                Content = text,
                Duration = duration,
				Image = 4483362458,
            })
        end

        local balloon = game.Workspace:FindFirstChild("GreenBalloon", true)

        if balloon then
            local balloonClone = balloon:Clone()
            balloonClone.Parent = game:GetService("Players").LocalPlayer.Backpack
            createNotif("DistiC", "Balloon Acquired", nil, 5)
        else
            createNotif("DistiC", "Balloon not available", nil, 5)
        end
    end,
})

-- Notification every 60 seconds
task.spawn(function()
    while true do
        task.wait(60)  -- Wait for 60 seconds
        Rayfield:Notify({
            Title = "DisticHUB",
            Content = "Don't forget to follow Instagram @disticx_",
            Duration = 8,  -- Notification duration (in seconds)
			Image = 4483362458,
        })
    end
end)