local Damage = CreateConVar("mu_fakemagnum_damage", 17, FCVAR_ARCHIVE + FCVAR_NOTIFY, "Damage caused by a fake magnum", 0,500)

local MagnumNames = {
    english = "Fake Magnum",
    russian = "Фальшивый Магнум",
    french = "Faux Magnum",
    german = "Falscher Magnum",
    italian = "Magnum falso",
    korean = "가짜 매그넘",
    polish = "Fałszywy magnum",
    portuguese = "Magnum falso",
    reverse = "mungaM ekaF",
    simplechinese = "假马格南",
    tradchinese = "假馬格南",
    spanish = "Magnum falso",
    turkish = "Sahte magnum",
    manee = "Feke Megnem"
}

local function GetName()
    local lang = GetConVarString("mu_language")
    
    return MagnumNames[lang] or MagnumNames["english"]
end

if SERVER then
	AddCSLuaFile()
else
	function SWEP:DrawWeaponSelection( x, y, w, h, alpha )
	end
end

SWEP.Base = "weapon_mers_base"
SWEP.Slot = 2
SWEP.SlotPos = 2
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.ViewModelFlip = false

SWEP.Author = "Airwaves"

SWEP.HoldType = "revolver"
SWEP.SequenceDraw = "draw"
SWEP.SequenceIdle = "idle01"
SWEP.SequenceHolster = "holster"

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Sound = "Weapon_357.Single"
SWEP.Primary.Sequence = "fire"
-- SWEP.Primary.Delay = 0.
SWEP.Primary.Cone = 0
SWEP.Primary.DryFireSequence = "fireempty"
SWEP.Primary.DryFireSound = Sound("Weapon_Pistol.Empty")
SWEP.Primary.Recoil = 9
SWEP.Primary.InfiniteAmmo = true
SWEP.Primary.AutoReload = true

SWEP.Primary.Damage = Damage:GetInt()

SWEP.ReloadSequence = "reload"
SWEP.ReloadSound = Sound("Weapon_357.Reload")

SWEP.PrintName = GetName()
function SWEP:Initialize()
	self.BaseClass.Initialize(self)
	self.PrintName = GetName()
	self:SetClip1(self:GetMaxClip1())
end

function SWEP:DoPrimaryAttackEffect(stats)
	local bullet = {}	-- Set up the shot
	bullet.Num = self.Primary.NumShots or 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector(stats.cone or 0, stats.cone or 0, 0)
	bullet.Tracer = 1
	bullet.Force = self.Primary.Force or ((self.Primary.Damage or 1) * 3)
	bullet.Damage = stats.damage or 1
	self.Owner:FireBullets(bullet)
end