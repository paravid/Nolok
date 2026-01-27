local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

if not getgenv().Animator6D or getgenv().Animator6DStop then
	getgenv().Animator6DLoadedPro = nil
	loadstring(game:HttpGet("https://raw.githubusercontent.com/gObl00x/Stuff/refs/heads/main/Animator6D.lua"))()
end

local URL = "https://github.com/paravid/RBMX-SCRIPTS/raw/refs/heads/main/kjj.rbxm"
local FILE = "kjj.rbxm"
local MORPH = "FULL KJ ANIMS"

local getAsset = customasset or getcustomasset or getsynasset
if not getAsset then
	warn("1")
	return
end

if not isfile(FILE) then
	writefile(FILE, game:HttpGet(URL))
end

local asset = game:GetObjects(getAsset(FILE))[1]
if not asset then
	warn("2")
	return
end

local rig = asset:FindFirstChild("FULL KJ ANIMS", true)
if not rig then
	warn("3")
	return
end

print("4", rig.Name, rig.ClassName)

local AnimSaves

for _, obj in ipairs(asset:GetDescendants()) do
	if obj.Name == "RBX_ANIMSAVES" then
		AnimSaves = obj
		break
	end
end

if not AnimSaves then
	warn("5")
	return
end

print("RBX_ANIMSAVES:", AnimSaves:GetFullName())

local DropKickAnim

for _, obj in ipairs(AnimSaves:GetDescendants()) do
	if obj:IsA("KeyframeSequence") and obj.Name == "dropkick" then
		DropKickAnim = obj
		break
	end
end

if not DropKickAnim then
	warn("DropKick não encontrada")
	return
end

print("6", DropKickAnim:GetFullName())
