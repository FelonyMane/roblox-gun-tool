--[[
	R6 Pistol Gun Tool
	Main handler for equip, shoot, reload, and effects
]]

local GUN_TOOL = script.Parent
local BARREL_END = GUN_TOOL:WaitForChild("BarrelEnd")
local AMMO_DISPLAY = GUN_TOOL:WaitForChild("AmmoDisplay")

local CONFIG = {
	FireRate = 0.1, -- Seconds between shots
	Damage = 25,
	BulletSpeed = 100,
	MaxAmmo = 15,
	CurrentAmmo = 15,
	ReloadTime = 2,
	EffectDistance = 500,
}

local STATE = {
	Equipped = false,
	CanShoot = true,
	IsReloading = false,
	LastShot = 0,
}

-- Load modules
local EffectsModule = require(script:WaitForChild("Effects"))
local AmmoModule = require(script:WaitForChild("AmmoSystem"))

-- Initialize ammo display
AmmoModule.Initialize(AMMO_DISPLAY, CONFIG.MaxAmmo, CONFIG.CurrentAmmo)

-- Equip event
GUN_TOOL.Equipped:Connect(function(mouse)
	STATE.Equipped = true
	print("Gun equipped!")
	
	-- Play equip effect
	EffectsModule.PlayEquipEffect(GUN_TOOL.Handle)
	
	-- Mouse click to shoot
	mouse.Button1Down:Connect(function()
		if STATE.Equipped and STATE.CanShoot and not STATE.IsReloading and CONFIG.CurrentAmmo > 0 then
			Shoot(mouse)
		end
	end)
	
	-- R key to reload
	mouse.KeyDown:Connect(function(key)
		if key:lower() == "r" and STATE.Equipped and not STATE.IsReloading then
			Reload()
		end
	end)
end)

-- Unequip event
GUN_TOOL.Unequipped:Connect(function()
	STATE.Equipped = false
	print("Gun unequipped!")
end)

-- Shoot function
function Shoot(mouse)
	STATE.CanShoot = false
	STATE.LastShot = tick()
	CONFIG.CurrentAmmo = CONFIG.CurrentAmmo - 1
	
	-- Update ammo display
	AmmoModule.UpdateAmmo(CONFIG.CurrentAmmo)
	
	-- Play muzzle flash
	EffectsModule.CreateMuzzleFlash(BARREL_END)
	
	-- Play shoot sound
	EffectsModule.PlaySound(BARREL_END, "Shoot")
	
	-- Spawn shell casing
	EffectsModule.SpawnShellCasing(BARREL_END)
	
	-- Create bullet and handle hit detection
	local targetPosition = mouse.Hit.Position
	CreateBullet(BARREL_END.Position, targetPosition)
	
	-- Fire rate cooldown
	task.wait(CONFIG.FireRate)
	STATE.CanShoot = true
end

-- Create bullet with raycast
function CreateBullet(startPos, endPos)
	local direction = (endPos - startPos).Unit
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {GUN_TOOL.Parent}
	
	local rayResult = workspace:Raycast(startPos, direction * CONFIG.EffectDistance, raycastParams)
	
	if rayResult then
		local hitPart = rayResult.Instance
		local hitPosition = rayResult.Position
		
		-- Deal damage to humanoid
		local humanoid = hitPart.Parent:FindFirstChild("Humanoid")
		if humanoid then
			humanoid:TakeDamage(CONFIG.Damage)
		end
		
		-- Create impact effect
		EffectsModule.CreateImpactEffect(hitPosition, rayResult.Normal)
		
		-- Create bullet hole
		if not hitPart.Parent:FindFirstChild("Humanoid") then
			EffectsModule.CreateBulletHole(hitPart, hitPosition, rayResult.Normal)
		end
		
		-- Play impact sound
		EffectsModule.PlaySound(hitPosition, "Impact")
	end
end

-- Reload function
function Reload()
	if CONFIG.CurrentAmmo == CONFIG.MaxAmmo then return end
	
	STATE.IsReloading = true
	print("Reloading...")
	
	-- Play reload sound
	EffectsModule.PlaySound(GUN_TOOL.Handle, "Reload")
	
	-- Play reload effect
	EffectsModule.PlayReloadEffect(GUN_TOOL.Handle)
	
	task.wait(CONFIG.ReloadTime)
	
	CONFIG.CurrentAmmo = CONFIG.MaxAmmo
	AmmoModule.UpdateAmmo(CONFIG.CurrentAmmo)
	
	STATE.IsReloading = false
	print("Reload complete!")
end

-- Expose config for adjustments
_G.GunConfig = CONFIG
