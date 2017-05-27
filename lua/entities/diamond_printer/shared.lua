ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Diamond Printer"
ENT.Category = "MavPrinters"
ENT.Spawnable = true

function ENT:SetupDataTables()

	self:NetworkVar("Int",1,"MoneyStored")

end