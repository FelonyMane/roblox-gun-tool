# R6 Roblox Gun Tool

A fully-featured R6 pistol tool with procedurally-generated effects, realistic shell casings, bullet holes, and a 3D ammo display system.

## Features

✨ **Muzzle Flash** - Procedurally generated with no textures needed
🔊 **Sound Effects** - Gunshot, reload, and impact sounds
🥫 **Shell Casings** - Physics-based casings that eject and fall
💥 **Impact Effects** - Spark particles and dust clouds on hit
🔫 **Bullet Holes** - Decals left on walls and objects
📦 **3D Ammo Display** - Floating ammo bullets next to the gun that react in real-time
⚡ **Hitscan Bullets** - Instant hit detection with damage
🎯 **R6 Compatible** - Works perfectly with R6 character models

## Setup Instructions

### Step 1: Create the Gun Tool in Roblox Studio

1. In **StarterPack**, insert a new **Tool** and name it `GunTool`
2. Inside **GunTool**, insert a **Part** and name it `Handle` (this is the gun model)
   - Customize the size/shape to look like a pistol
   - Suggested size: `(0.5, 2, 4)` with appropriate positioning

### Step 2: Add Required Parts

Inside **GunTool**, create these additional parts:

1. **BarrelEnd** (Part)
   - Position at the tip of your gun barrel
   - Size: `(0.2, 0.2, 0.5)`
   - This is where bullets spawn and effects play

2. **AmmoDisplay** (Part)
   - Position next to the gun (side of the handle)
   - Size: `(2, 0.5, 0.5)`
   - Material: `Neon` for visibility
   - Transparency: `0.3` (optional, will hold ammo bullets)

### Step 3: Add Scripts

1. **In GunTool**, insert a **LocalScript** named `GunScript`
   - Copy the contents of `GunTool.lua` into this script

2. **In GunTool**, insert a **ModuleScript** named `Effects`
   - Copy the contents of `Effects.lua` into this script

3. **In GunTool**, insert a **ModuleScript** named `AmmoSystem`
   - Copy the contents of `AmmoSystem.lua` into this script

### Step 4: Configure

In the **GunTool.lua** script, you can modify the `CONFIG` table:

```lua
local CONFIG = {
	FireRate = 0.1,      -- Seconds between shots
	Damage = 25,         -- Damage per shot
	MaxAmmo = 15,        -- Ammo capacity
	ReloadTime = 2,      -- Reload duration in seconds
	EffectDistance = 500, -- How far bullets travel
}
```

## Usage

- **Left Click** - Shoot
- **R Key** - Reload
- **Click away from the gun** - Unequip

## Files

- `GunTool.lua` - Main gun script (LocalScript)
- `Effects.lua` - Effects module (muzzle flash, shells, impacts)
- `AmmoSystem.lua` - 3D ammo display system (ModuleScript)
- `README.md` - This file

## Customization

### Change Ammo Count
Edit `MaxAmmo` in the CONFIG table

### Adjust Damage
Edit `Damage` in the CONFIG table

### Modify Effects Speed
In `Effects.lua`, change timing values like `duration = 0.1`

### Customize Gun Appearance
Modify the `Handle` part's size, color, and shape in Studio

### Add Custom Sounds
Replace the sound IDs in `Effects.lua` with your own Roblox audio IDs

## Tips

- Ensure the **BarrelEnd** part is positioned exactly where you want bullets to come from
- The **AmmoDisplay** part should be clearly visible next to the gun
- Test in a local game to fine-tune the visual effects
- Adjust `FireRate` for faster/slower shooting
- Experiment with `BulletSpeed` for different projectile velocities

## Future Enhancements

- [ ] Zoom ADS (Aim Down Sights)
- [ ] Automatic/Burst fire modes
- [ ] Customizable textures
- [ ] Tracer bullets
- [ ] Muzzle smoke
- [ ] Recoil animation
- [ ] Magazine system

---

Made with ❤️ for Roblox developers
