-- Ranks that can access the VIP printers (case sensitive)
local VIPRanks = {
	"superadmin",
	"vip"
}
-- Making a custom category for the printers
DarkRP.createCategory{
    name = "SimplePrinters",
    categorises = "entities",
    startExpanded = true,
    color = Color(0, 168, 33, 255),
    canSee = function(ply) return true end,
    sortOrder = 999
}

-- Creating the entities so they are buyable
DarkRP.createEntity("Copper Printer", {
    ent = "tier1",
    model = "models/props_c17/consolebox01a.mdl",
    price = 5000,
    max = 2,
    cmd = "buytier1",
    category = "SimplePrinters"
})

DarkRP.createEntity("Silver Printer", {
    ent = "tier2",
    model = "models/props_c17/consolebox01a.mdl",
    price = 10000,
    max = 2,
    cmd = "buytier2",
    category = "SimplePrinters"
})

DarkRP.createEntity("Gold Printer", {
    ent = "tier3",
    model = "models/props_c17/consolebox01a.mdl",
    price = 15000,
    max = 2,
    cmd = "buytier3",
    category = "SimplePrinters"
})

DarkRP.createEntity("Diamond Printer", {
    ent = "tier4",
    model = "models/props_c17/consolebox01a.mdl",
    price = 20000,
    max = 2,
    cmd = "buytier4",
    category = "SimplePrinters",
    customCheck = function(ply) return CLIENT or
    table.HasValue(VIPRanks, ply:GetNWString("usergroup"))
	end,
	CustomCheckFailMsg = "You're not a VIP"
})

DarkRP.createEntity("Ruby Printer", {
    ent = "tier5",
    model = "models/props_c17/consolebox01a.mdl",
    price = 25000,
    max = 2,
    cmd = "buytier5",
    category = "SimplePrinters",
    customCheck = function(ply) return CLIENT or
    table.HasValue(VIPRanks, ply:GetNWString("usergroup"))
	end,
	CustomCheckFailMsg = "You're not a VIP"
})

DarkRP.createEntity("Printer Silencer", {
    ent = "silence_printer",
    model = "models/props_lab/reciever01a.mdl",
    price = 15000,
    max = 5,
    cmd = "buyprintersilencer",
    category = "SimplePrinters"
})