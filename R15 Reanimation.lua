local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer
local workspace = game.Workspace
local mouse = plr:GetMouse()
local camera = workspace.CurrentCamera
local Character = plr.Character
local hum = Character.Humanoid 
 
local v3_net, v3_808 = Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)    
        function getNetlessVelocity(realPartVelocity)
            local mag = realPartVelocity.Magnitude
            if mag > 0 then
                local unit = realPartVelocity.Unit
                if unit.Y ~= 0 then
                    return unit * (0.0 / unit.Y)  
                end
            end
            return v3_net + realPartVelocity * v3_808
        end
        
        
        local simradius = "shp" 
        local simrad = 0 
        local healthHide = false 
        local reclaim = true 
        
        local novoid = true 
        local physp = nil 
        
        local noclipAllParts = false 
        local antiragdoll = false 
        local newanimate = true 
        local discharscripts = false 
        local hatcollide = false 
        local humState16 = true 
        local addtools = false 
        local hedafterneck = true 
        local loadtime = game:GetService("Players").RespawnTime + 0.5 
        local method = 3 
        
        local alignmode = 4 
        local flingpart = "HumanoidRootPart" 
        
        local lp = game:GetService("Players").LocalPlayer
        local rs, ws, sg = game:GetService("RunService"), game:GetService("Workspace"), game:GetService("StarterGui")    
        local stepped, heartbeat, renderstepped = rs.Stepped, rs.Heartbeat, rs.RenderStepped
        local twait, tdelay, rad, inf, abs, clamp = task.wait, task.delay, math.rad, math.huge, math.abs, math.clamp
        local cf, v3 = CFrame.new, Vector3.new
        local v3_0, v3_101, v3_010, v3_d, v3_u = v3(0, 0, 0), v3(1, 0, 1), v3(0, 1, 0), v3(0, -10000, 0), v3(0, 10000, 0)

        local angles = CFrame.Angles
        local v3_0, cf_0 = v3(0, 0, 0), cf(0, 0, 0)
        
        local c = lp.Character
        if not (c and c.Parent) then
            return
        end
        
        spawn(function()
                if ReplicatedStorage and ReplicatedStorage:FindFirstChild("Ragdoll") then
                    local args = {
                    	"Hinge"
                    }
                game:GetService("ReplicatedStorage"):WaitForChild("Ragdoll"):FireServer(unpack(args))
                elseif ReplicatedStorage and ReplicatedStorage:FindFirstChild("LocalRagdollEvent") then
                    local v1 = game:GetService("ReplicatedStorage")
                    local v_u_4 = v1:WaitForChild("Events"):WaitForChild("RagdollState")
                    v_u_4:FireServer(true)
                    ReplicatedStorage.LocalRagdollEvent:Fire(true)
                    game.Players.LocalPlayer.Character["State Handler"].Enabled = false
                    game.Players.LocalPlayer.Character["Local Ragdoll"].Enabled = false
                    game.Players.LocalPlayer.Character.Camera.Enabled = false
                end
        end)

        wait(0.1)
        c:GetPropertyChangedSignal("Parent"):Connect(function()
            if not (c and c.Parent) then
                c = nil
            end
        end)
        
        local clone, destroy, getchildren, getdescendants, isa = c.Clone, c.Destroy, c.GetChildren, c.GetDescendants, c.IsA
        
        function gp(parent, name, className)
            if typeof(parent) == "Instance" then
                for i, v in pairs(getchildren(parent)) do
                    if (v.Name == name) and isa(v, className) then
                        return v
                    end
                end
            end
            return nil
        end
        
        local fenv = getfenv()
        local shp = fenv.sethiddenproperty or fenv.set_hidden_property or fenv.set_hidden_prop or fenv.sethiddenprop
        local ssr = fenv.setsimulationradius or fenv.set_simulation_radius or fenv.set_sim_radius or fenv.setsimradius or fenv.setsimrad or fenv.set_sim_rad
        
        healthHide = healthHide and ((method == 0) or (method == 3)) and gp(c, "Head", "BasePart")
        
        local reclaim, lostpart = reclaim and c.PrimaryPart, nil
        
        function align(Part0, Part1)
            local att0 = Instance.new("Attachment")
            att0.Position, att0.Orientation, att0.Name = v3_0, v3_0, "att0_" .. Part0.Name
            local att1 = Instance.new("Attachment")
            att1.Position, att1.Orientation, att1.Name = v3_0, v3_0, "att1_" .. Part1.Name
        
            if alignmode == 4 then
                local hide = false
                if Part0 == healthHide then
                    healthHide = false
                    tdelay(0, function()
                        while twait(2.9) and Part0 and c do
                            hide = #Part0:GetConnectedParts() == 1
                            twait(0.1)
                            hide = false
                        end
                    end)
                end
        
                local rot = rad(0.05)
                local con0, con1 = nil, nil
                con0 = stepped:Connect(function()
                    if not (Part0 and Part1) or not plr.Character or not plr.Character:FindFirstChild("UpperTorso") then 
                        
                        con0:Disconnect() 
                        con1:Disconnect() 
                        return 
                    end
                    plr.Character.UpperTorso.CanCollide = false
                    plr.Character.LowerTorso.CanCollide = false
                    Part0.RotVelocity = Part1.RotVelocity
                end)

                local lastpos = Part0.Position
                con1 = heartbeat:Connect(function(delta)
                    if not (Part0 and Part1 and att1) then return con0:Disconnect() and con1:Disconnect()  end
                    if (not Part0.Anchored) and (Part0.ReceiveAge == 0) then
                        if lostpart == Part0 then
                            lostpart = nil
                        end
                        rot = -rot
                        local newcf = Part1.CFrame * att1.CFrame * angles(0, 0, rot)
                        if Part1.Velocity.Magnitude > 0.01 then
                            Part0.Velocity = getNetlessVelocity(Part1.Velocity)
                        else
                            Part0.Velocity = getNetlessVelocity((newcf.Position - lastpos) / delta)
                        end
                        lastpos = newcf.Position
                        if lostpart and (Part0 == reclaim) then
                            newcf = lostpart.CFrame
                        elseif hide then
                            newcf += v3(0, 3000, 0)
                        end
                        if novoid and (newcf.Y < ws.FallenPartsDestroyHeight + 0.1) then
                            newcf += v3(0, ws.FallenPartsDestroyHeight + 0.1 - newcf.Y, 0)
                        end
                        Part0.CFrame = newcf
                    elseif (not Part0.Anchored) and (abs(Part0.Velocity.X) < 45) and (abs(Part0.Velocity.Y) < 25) and (abs(Part0.Velocity.Z) < 45) then
                        lostpart = Part0
                    end
                end)
            else
                Part0.CustomPhysicalProperties = physp
            end
        
            att0:GetPropertyChangedSignal("Parent"):Connect(function()
                Part0 = att0.Parent
                if not isa(Part0, "BasePart") then
                    att0 = nil
                    if lostpart == Part0 then
                        lostpart = nil
                    end
                    Part0 = nil
                end
            end)
            att0.Parent = Part0
        
            att1:GetPropertyChangedSignal("Parent"):Connect(function()
                Part1 = att1.Parent
                if not isa(Part1, "BasePart") then
                    att1 = nil
                    Part1 = nil
                end
            end)
            att1.Parent = Part1
        end
        
        function respawnrequest()
            local ccfr, c = ws.CurrentCamera.CFrame, lp.Character
            lp.Character = nil
            lp.Character = c
            local con = nil
            con = ws.CurrentCamera.Changed:Connect(function(prop)
                if (prop ~= "Parent") and (prop ~= "CFrame") then
                    return
                end
                ws.CurrentCamera.CFrame = ccfr
                con:Disconnect()
            end)
        end
        
        local destroyhum = (method == 4) or (method == 5)
        local breakjoints = (method == 0) or (method == 4)
        local antirespawn = (method == 0) or (method == 2) or (method == 3)
        
        hatcollide = hatcollide and (method == 0)
        
        addtools = addtools and lp:FindFirstChildOfClass("Backpack")
        
        if type(simrad) ~= "number" then simrad = 1000 end
        if shp and (simradius == "shp") then
            tdelay(0, function()
                while c do
                    shp(lp, "SimulationRadius", simrad)
                    heartbeat:Wait()
                end
            end)
        elseif ssr and (simradius == "ssr") then
            tdelay(0, function()
                while c do
                    ssr(simrad)
                    heartbeat:Wait()
                end
            end)
        end
        
        if antiragdoll then
            antiragdoll = function(v)
                if isa(v, "HingeConstraint") or isa(v, "BallSocketConstraint") then
                    v.Parent = nil
                end
            end
            for i, v in pairs(getdescendants(c)) do
                antiragdoll(v)
            end
            c.DescendantAdded:Connect(antiragdoll)
        end
        
        if antirespawn then
            
        end
        
        if method == 0 then
            twait(loadtime)
            if not c then
                return
            end
        end
        
        if discharscripts then
            for i, v in pairs(getdescendants(c)) do
                if isa(v, "LocalScript") then
                    v.Disabled = true
                end
            end
        elseif newanimate then
            local animate = gp(c, "Animate", "LocalScript")
            if animate and (not animate.Disabled) then
                animate.Disabled = true
            else
                newanimate = false
            end
        end
        
        if addtools then
            for i, v in pairs(getchildren(addtools)) do
                if isa(v, "Tool") then
                    v.Parent = c
                end
            end
        end
        
        pcall(function()
            settings().Physics.AllowSleep = false
            settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
        end)
        
        local OLDscripts = {}
        
        for i, v in pairs(getdescendants(c)) do
            if v.ClassName == "Script" then
                OLDscripts[v.Name] = true
            end
        end
        
        local scriptNames = {}
        
        for i, v in pairs(getdescendants(c)) do
            if isa(v, "BasePart") then
                local newName, exists = tostring(i), true
                while exists do
                    exists = OLDscripts[newName]
                    if exists then
                        newName = newName .. "_"    
                    end
                end
                table.insert(scriptNames, newName)
                Instance.new("Script", v).Name = newName
            end
        end
        
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then
            for i, v in pairs(hum:GetPlayingAnimationTracks()) do
                v:Stop()
            end
        end
        c.Archivable = true
        local cl = clone(c)
        if hum and humState16 then
            hum:ChangeState(Enum.HumanoidStateType.Physics)
            if destroyhum then
                twait(1.6)
            end
        end
        if destroyhum then
            pcall(destroy, hum)
        end
        
        if not c then
            return
        end
        
        local head, torso, root = gp(c, "Head", "BasePart"), gp(c, "Torso", "BasePart") or gp(c, "UpperTorso", "BasePart"), gp(c, "HumanoidRootPart", "BasePart")
        if hatcollide then
            pcall(destroy, torso)
            pcall(destroy, root)
            pcall(destroy, c:FindFirstChildOfClass("BodyColors") or gp(c, "Health", "Script"))
        end
        
        local model = Instance.new("Model", c)
        model:GetPropertyChangedSignal("Parent"):Connect(function()
            if not (model and model.Parent) then
                model = nil
            end
        end)
        
        for i, v in pairs(getchildren(c)) do
            if v ~= model then
                if addtools and isa(v, "Tool") then
                    for i1, v1 in pairs(getdescendants(v)) do
                        if v1 and v1.Parent and isa(v1, "BasePart") then
                            local bv = Instance.new("BodyVelocity")
                            
                            bv.Velocity, bv.MaxForce, bv.P, bv.Name = v3_0, v3(1000, 1000, 1000), 1250, "bv_" .. v.Name
                            bv.Parent = v1
                        end
                    end
                end
                v.Parent = model
            end
        end
        
        if breakjoints then
            model:BreakJoints()
        else
            if head and torso then
                for i, v in pairs(getdescendants(model)) do
                    if isa(v, "JointInstance") then
                        local save = false
                        if (v.Part0 == torso) and (v.Part1 == head) then
                            save = true
                        end
                        if (v.Part0 == head) and (v.Part1 == torso) then
                            save = true
                        end
                        if save then
                            if hedafterneck then
                                hedafterneck = v
                            end
                        else
                            pcall(destroy, v)
                        end
                    end
                end
            end
            if method == 3 then
                task.delay(loadtime, pcall, model.BreakJoints, model)
            end
        end
        
        cl.Parent = ws
        for i, v in pairs(getchildren(cl)) do
            v.Parent = c
        end
        pcall(destroy, cl)
        
        local uncollide, noclipcon = nil, nil
        if noclipAllParts then
            uncollide = function()
                if c then
                    for i, v in pairs(getdescendants(c)) do
                        if isa(v, "BasePart") then
                            v.CanCollide = false
                        end
                    end
                else
                    noclipcon:Disconnect()
                end
            end
        else
            uncollide = function()
                if model then
                    for i, v in pairs(getdescendants(model)) do
                        if isa(v, "BasePart") then
                            v.CanCollide = false
                        end
                    end
                else
                    noclipcon:Disconnect()
                end
            end
        end
        noclipcon = stepped:Connect(uncollide)
        uncollide()
        
        for i, scr in pairs(getdescendants(model)) do
            if (scr.ClassName == "Script") and table.find(scriptNames, scr.Name) then
                local Part0 = scr.Parent
                if isa(Part0, "BasePart") then
                    for i1, scr1 in pairs(getdescendants(c)) do
                        if (scr1.ClassName == "Script") and (scr1.Name == scr.Name) and (not scr1:IsDescendantOf(model)) then
                            local Part1 = scr1.Parent
                            if (Part1.ClassName == Part0.ClassName) and (Part1.Name == Part0.Name) then
                                align(Part0, Part1)
                                pcall(destroy, scr)
                                pcall(destroy, scr1)
                                break
                            end
                        end
                    end
                end
            end
        end
        
        for i, v in pairs(getdescendants(c)) do
            if v and v.Parent and (not v:IsDescendantOf(model)) then
                if isa(v, "Decal") then
                elseif isa(v, "BasePart") then
                    v.Anchored = false
                elseif isa(v, "ForceField") then
                    v.Visible = false
                elseif isa(v, "Sound") then
                    v.Playing = false
                elseif isa(v, "BillboardGui") or isa(v, "SurfaceGui") or isa(v, "ParticleEmitter") or isa(v, "Fire") or isa(v, "Smoke") or isa(v, "Sparkles") then
                    v.Enabled = false
                end
            end
        end
        
        if newanimate then
            local animate = gp(c, "Animate", "LocalScript")
            if animate then
                animate.Disabled = false
            end
        end
        
        if addtools then
            for i, v in pairs(getchildren(c)) do
                if isa(v, "Tool") then
                    v.Parent = addtools
                end
            end
        end
        
        local hum0, hum1 = model:FindFirstChildOfClass("Humanoid"), c:FindFirstChildOfClass("Humanoid")
        if hum0 then
            hum0:GetPropertyChangedSignal("Parent"):Connect(function()
                if not (hum0 and hum0.Parent) then
                    hum0 = nil
                end
            end)
        end
        if hum1 then
            hum1:GetPropertyChangedSignal("Parent"):Connect(function()
                if not (hum1 and hum1.Parent) then
                    hum1 = nil
                end
            end)
        
            ws.CurrentCamera.CameraSubject = hum1

        end
       
        function setTransparency(model, transparencyValue)
            for _, descendant in ipairs(model:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.Transparency = transparencyValue
                end
            end
        end
        
        
        setTransparency(plr.Character.Model, 1)
        plr.Character.Model.Head.Transparency = 0
        plr.Character.Head.Transparency = 1
        local rb = Instance.new("BindableEvent", c)
        rb.Event:Connect(function()
            pcall(destroy, rb)
            sg:SetCore("ResetButtonCallback", true)
            if destroyhum then
                if c then c:BreakJoints() end
                return
            end
            if model and hum0 and (hum0.Health > 0) then
                model:BreakJoints()
                hum0.Health = 0
            end
            if antirespawn then
                
            end
        end)
        
        sg:SetCore("ResetButtonCallback", rb)
        
        tdelay(0, function()
            while c do
                if hum0 and hum1 then
                    hum1.Jump = hum0.Jump
                end
                wait()
            end
            sg:SetCore("ResetButtonCallback", true)
        end)
        
        
        local R15toR6 = false 
        if R15toR6 and hum1 and (hum1.RigType == Enum.HumanoidRigType.R15) then
        end
        
        
        local torso1 = torso
        torso = gp(c, "Torso", "BasePart") or ((not R15toR6) and gp(c, torso.Name, "BasePart"))
        if (typeof(hedafterneck) == "Instance") and head and torso and torso1 then
            local conNeck, conTorso, conTorso1 = nil, nil, nil
            local aligns = {}
            function enableAligns()
                if conNeck then conNeck:Disconnect() end
                if conTorso then conTorso:Disconnect() end
                if conTorso1 then conTorso1:Disconnect() end
                for i, v in pairs(aligns) do
                    v.Enabled = true
                end
            end
            conNeck = hedafterneck.Changed:Connect(function(prop)
                if table.find({"Part0", "Part1", "Parent"}, prop) then
                    enableAligns()
                end
            end)
            conTorso = torso:GetPropertyChangedSignal("Parent"):Connect(enableAligns)
            conTorso1 = torso1:GetPropertyChangedSignal("Parent"):Connect(enableAligns)
            for i, v in pairs(getdescendants(head)) do
                if isa(v, "AlignPosition") or isa(v, "AlignOrientation") then
                    i = tostring(i)
                    aligns[i] = v
                    v:GetPropertyChangedSignal("Parent"):Connect(function()
                        aligns[i] = nil
                    end)
                    v.Enabled = false
                end
            end
        end 

    local root_part = plr.Character.HumanoidRootPart
    local initial_cframe = root_part.CFrame
    local old_cframe = initial_cframe * CFrame.new(-111, 60, -11210) * CFrame.Angles(math.rad(180), 0, 0)

    plr.Character.Humanoid:ChangeState(3)
        getgenv().MapPooperss = MapPooper
        local originalpositon = plr.Character.HumanoidRootPart.CFrame        
        
        local renderConnection
        plr.Character.Humanoid:ChangeState(3)
        if not getgenv().MapPooperss then
            if renderConnection then
                renderConnection:Disconnect()
                wait(1)
                plr.Character.HumanoidRootPart.CFrame = originalpositon
                plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            end
        spawn(function()
                if ReplicatedStorage and ReplicatedStorage:FindFirstChild("Ragdoll") then
                game:GetService("ReplicatedStorage"):WaitForChild("Unragdoll"):FireServer()
                elseif ReplicatedStorage and ReplicatedStorage:FindFirstChild("LocalRagdollEvent") then
                    local v1 = game:GetService("ReplicatedStorage")
                    local v_u_4 = v1:WaitForChild("Events"):WaitForChild("RagdollState")
                    v_u_4:FireServer(false)
                    ReplicatedStorage.LocalRagdollEvent:Fire(false)
                    game.Players.LocalPlayer.Character["State Handler"].Enabled = true
                    game.Players.LocalPlayer.Character["Local Ragdoll"].Enabled = true
                    game.Players.LocalPlayer.Character.Camera.Enabled = true
                end
        end)

            plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        end

        local players = game:GetService("Players")
        local run_service = game:GetService("RunService")
        local replicated_storage = game:GetService("ReplicatedStorage")
        local local_player = players.LocalPlayer

        local character = local_player.Character

        local offset = 100000
        task.wait()
        local head = character.Head
        local upper_torso = character.UpperTorso
        local lower_torso = character.LowerTorso

        local right_upper_arm = character.RightUpperArm
        local right_lower_arm = character.RightLowerArm
        local right_hand = character.RightHand

        local left_upper_arm = character.LeftUpperArm
        local left_lower_arm = character.LeftLowerArm
        local left_hand = character.LeftHand

        local right_upper_leg = character.RightUpperLeg
        local right_lower_leg = character.RightLowerLeg
        local right_foot = character.RightFoot

        local left_upper_leg = character.LeftUpperLeg
        local left_lower_leg = character.LeftLowerLeg
        local left_foot = character.LeftFoot


        function set_velocity_to_zero(part)
            part.AssemblyLinearVelocity = Vector3.zero
            part.AssemblyAngularVelocity = Vector3.zero
        end
        plr.Character.HumanoidRootPart.CFrame = originalpositon
        function SimulateJump()
            local Humanoid = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid")
            game:GetService("VirtualUser"):SetKeyDown("0x20");
            task.wait(0.1);
            game:GetService("VirtualUser"):SetKeyUp("0x20");
            repeat task.wait() until Humanoid:GetState().Value == 7; 
        end

        SimulateJump()

        spawn(function()
                if ReplicatedStorage and ReplicatedStorage:FindFirstChild("event_rag") then
                    local args = {
                        "Ball"
                    }
                    ReplicatedStorage:WaitForChild("Ragdoll"):FireServer(unpack(args))
                elseif ReplicatedStorage and ReplicatedStorage:FindFirstChild("LocalRagdollEvent") then
                    local v1 = game:GetService("ReplicatedStorage")
                    local v_u_4 = v1:WaitForChild("Events"):WaitForChild("RagdollState")
                    v_u_4:FireServer(true)
                    ReplicatedStorage.LocalRagdollEvent:Fire(true)
                    game.Players.LocalPlayer.Character["State Handler"].Enabled = false
                    game.Players.LocalPlayer.Character["Local Ragdoll"].Enabled = false
                    game.Players.LocalPlayer.Character.Camera.Enabled = false
                end
        end)

        renderConnection = run_service.Heartbeat:Connect(function()
            if not getgenv().MapPooperss then
                renderConnection:Disconnect()
                return
            end

            plr.Character.HumanoidRootPart.CFrame = originalpositon
            head.CFrame = old_cframe * CFrame.new(0, 0, offset / 2)
            upper_torso.CFrame = old_cframe * CFrame.new(0, -offset / 1232, 20)
            lower_torso.CFrame = old_cframe * CFrame.new(0, -offset / 1232, 20)

            right_upper_arm.CFrame = old_cframe * CFrame.new(offset, 1230, 0)
            right_lower_arm.CFrame = old_cframe * CFrame.new(offset * 1231.5, 0, 20)
            right_hand.CFrame = old_cframe * CFrame.new(offset * 2, 0, 0)
        
            left_upper_arm.CFrame = old_cframe * CFrame.new(-offset, 0, 0)
            left_lower_arm.CFrame = old_cframe * CFrame.new(-offset * 1123.5, 0, 20)
            left_hand.CFrame = old_cframe * CFrame.new(-offset * 2, 0, 0)
        
            right_upper_leg.CFrame = old_cframe * CFrame.new(offset / 2, -offset, 20)
            right_lower_leg.CFrame = old_cframe * CFrame.new(offset / 2, -offset * 123311.5, 20)
            right_foot.CFrame = old_cframe * CFrame.new(offset / 2, -offset * 1121233, 20)
        
            left_upper_leg.CFrame = old_cframe * CFrame.new(-offset / 2, -offset, 20)
            left_lower_leg.CFrame = old_cframe * CFrame.new(-offset / 2, -offset * 111233111.5, 20)
            left_foot.CFrame = old_cframe * CFrame.new(-offset / 2, -offset * 11112, 20)

            set_velocity_to_zero(head)
            set_velocity_to_zero(upper_torso)
            set_velocity_to_zero(lower_torso)
            set_velocity_to_zero(right_upper_arm)
            set_velocity_to_zero(right_lower_arm)
            set_velocity_to_zero(right_hand)
            set_velocity_to_zero(left_upper_arm)
            set_velocity_to_zero(left_lower_arm)
            set_velocity_to_zero(left_hand)
            set_velocity_to_zero(right_upper_leg)
            set_velocity_to_zero(right_lower_leg)
            set_velocity_to_zero(right_foot)
            set_velocity_to_zero(left_upper_leg)
            set_velocity_to_zero(left_lower_leg)
            set_velocity_to_zero(left_foot)
        end)

    local StopAnim = true
    local AnimationActive = false
    local CurrentAnimationID = nil
    
    function isValidAnimationID(animationID)
        local success, asset = pcall(function()
            return game:GetObjects("rbxassetid://" .. animationID)[1]
        end)
        return success and asset ~= nil
    end
    
    local CurrentAnimTask = nil
    R157 = R157 or 1

    function stopCurrentAnimation()
        AnimationActive = false
        StopAnim = true
        if CurrentAnimTask then
            coroutine.close(CurrentAnimTask)
                CurrentAnimTask = nil
            end
        
            local character = game.Players.LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid and humanoid:FindFirstChild("Animator") then
                    humanoid.Animator:Destroy()
                end
                if character:FindFirstChild("Animate") then
                    character.Animate.Enabled = true
                end
            end
        end
    
        function getJoints(character)
            local jointMap = {
                ["Torso"] = "RootJoint", ["Head"] = "Neck", ["LeftUpperArm"] = "LeftShoulder",
                ["RightUpperArm"] = "RightShoulder", ["LeftUpperLeg"] = "LeftHip", ["RightUpperLeg"] = "RightHip",
                ["LeftFoot"] = "LeftAnkle", ["RightFoot"] = "RightAnkle", ["LeftHand"] = "LeftWrist",
                ["RightHand"] = "RightWrist", ["LeftLowerArm"] = "LeftElbow", ["RightLowerArm"] = "RightElbow",
                ["LeftLowerLeg"] = "LeftKnee", ["RightLowerLeg"] = "RightKnee", ["LowerTorso"] = "Root",
                ["UpperTorso"] = "Waist"
            }
        
            local joints = {}
            for partName, jointName in pairs(jointMap) do
                local part = character:FindFirstChild(partName)
                if part then
                    local joint = part:FindFirstChild(jointName)
                    if joint then
                        joints[partName] = joint
                    end
                end
            end
            return joints
        end