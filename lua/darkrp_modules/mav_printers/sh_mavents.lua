DarkRP.createEntity("Bronze Printer", {
    ent = "bronze_printer",
    model = "models/props_lab/reciever01a.mdl",
    price = 2500,
    max = 2,
    cmd = "buybronzeprinter",
    category = "Other"
})

DarkRP.createEntity("Silver Printer", {
    ent = "silver_printer",
    model = "models/props_lab/reciever01a.mdl",
    price = 5000,
    max = 2,
    cmd = "buysilverprinter",
    category = "Other"
})

DarkRP.createEntity("Gold Printer", {
    ent = "gold_printer",
    model = "models/props_lab/reciever01a.mdl",
    price = 7500,
    max = 2,
    cmd = "buygoldprinter",
    category = "Other"
})

DarkRP.createEntity("Diamond Printer(VIP)", {
    ent = "diamond_printer",
    model = "models/props_lab/reciever01a.mdl",
    price = 5000,
    max = 2,
    cmd = "buydiamondprinter",
    category = "Other",
    customCheck = function(ply) return CLIENT or
    table.HasValue({vipRanks}, ply:GetNWString("usergroup"))
end,
CustomCheckFailMsg = "You're not a VIP!",
})