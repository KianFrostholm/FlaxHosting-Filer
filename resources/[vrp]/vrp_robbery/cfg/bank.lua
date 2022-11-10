cfg = {}

cfg.blips = false -- blips/markeringer på mappet.

cfg.seconds = 600 -- sekunder at røve i. (10 minutter)

cfg.cooldown = 120 -- tid mellem røverierne i banken. (Én time)

cfg.cops = 4 -- minimum betjente på arbejde.

cfg.permission = "police.pc" -- tilladelse givet til politiet.

cfg.banks = { -- liste af bankene
	["Midtby Bank"] = {
		position = { ['x'] = 147.0697479248, ['y'] = -1045.05859375, ['z'] = 29.368026733398 },
		reward = math.random(200000,400000),
		nameofbank = "Midtby Bank",
		lastrobbed = 0 -- den er altid på 0
	},
	["Nordea Bank"] = {
		position = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.697026252747 },
		reward = math.random(200000,400000),
		nameofbank = "Nordea Bank (Vestlig Motorvej)",
		lastrobbed = 0
	},
	["Jyske Bank"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		reward = math.random(200000,400000),
		nameofbank = "Jyske Bank (Paleto Bay)",
		lastrobbed = 0
	},
	["Sydbank"] = {
		position = { ['x'] = -1212.2568359375, ['y'] = -336.128295898438, ['z'] = 36.7907638549805 },
		reward = math.random(200000,400000),
		nameofbank = "Sydbank (Rockford Hills - Vestlig Los Santos)",
		lastrobbed = 0
	},
	["Alm. Brand Bank"] = {
		position = { ['x'] = 309.967376708984, ['y'] = -283.033660888672, ['z'] = 53.1745223999023 },
		reward = math.random(200000,400000),
		nameofbank = "Alm. Brand Bank (Alta - Nord for LS Midtby)",
		lastrobbed = 0
	},
	["7/11 (1/20)"] = {
		mincops = 2,
		position = { ['x'] = 28.933782577515, ['y'] = -1339.3140869141, ['z'] = 29.497022628784 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (1/20)",
		lastrobbed = 0
	},
	["7/11 (2/20)"] = {
		mincops = 2,
		position = { ['x'] = 1130.5788574219, ['y'] = -981.38562011719, ['z'] = 46.415809631348 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (2/20)",
		lastrobbed = 0
	},
	["7/11 (3/20)"] = {
		mincops = 2,
		position = { ['x'] = 1161.1119384766, ['y'] = -315.33432006836, ['z'] = 69.205146789551 }, 
		reward = math.random(20000,60000),
		nameofbank = "7/11 (3/20)",
		lastrobbed = 0
	},
	["7/11 (4/20)"] = {
		mincops = 2,
		position = { ['x'] = 378.09088134766, ['y'] = 333.05822753906, ['z'] = 103.56636047363 }, 
		reward = math.random(20000,60000),
		nameofbank = "7/11 (4/20)",
		lastrobbed = 0
	},
	["7/11 (5/20)"] = {
		mincops = 2,
		position = { ['x'] = 2549.7045898438, ['y'] = 384.81210327148, ['z'] = 108.62300109863 }, 
		reward = math.random(20000,60000),
		nameofbank = "7/11 (5/20)",
		lastrobbed = 0
	},
	["7/11 (6/20)"] = {
		mincops = 2,
		position = { ['x'] = 2673.0493164063, ['y'] = 3286.3425292969, ['z'] = 55.241134643555 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (6/20)",
		lastrobbed = 0
	},
	["7/11 (7/20)"] = {
		mincops = 2,
		position = { ['x'] = 1959.3483886719, ['y'] = 3748.40234375, ['z'] = 32.343742370605 }, 
		reward = math.random(20000,60000),
		nameofbank = "7/11 (7/20)",
		lastrobbed = 0
	},
	["7/11 (8/20)"] = {
		mincops = 2,
		position = { ['x'] = 1391.0627441406, ['y'] = 3608.3505859375, ['z'] = 34.980926513672 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (8/20)",
		lastrobbed = 0
	},
	["7/11 (9/20)"] = {
		mincops = 2,
		position = { ['x'] = 1166.4384765625, ['y'] = 2714.4787597656, ['z'] = 38.157711029053 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (9/20)",
		lastrobbed = 0
	},
	["7/11 (10/20)"] = {
		mincops = 2,
		position = { ['x'] = 546.40325927734, ['y'] = 2663.1550292969, ['z'] = 42.156494140625 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (10/20)",
		lastrobbed = 0
	},
	["7/11 (11/20)"] = {
		mincops = 2,
		position = { ['x'] = 1705.4091796875, ['y'] = 4920.5083007813, ['z'] = 42.063678741455 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (11/20)",
		lastrobbed = 0
	},
	["7/11 (12/20)"] = {
		mincops = 2,
		position = { ['x'] = 1734.5924072266, ['y'] = 6420.43359375, ['z'] = 35.037261962891 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (12/20)",
		lastrobbed = 0
	},
	["7/11 (13/20)"] = {
		mincops = 2,
		position = { ['x'] = -3249.7241210938, ['y'] = 1004.3265380859, ['z'] = 12.830704689026 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (13/20)",
		lastrobbed = 0
	},
	["7/11 (14/20)"] = {
		mincops = 2,
		position = { ['x'] = -2962.9799804688, ['y'] = 389.36978149414, ['z'] = 15.043312072754 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (14/20)",
		lastrobbed = 0
	},
	["7/11 (15/20)"] = {
		mincops = 2,
		position = { ['x'] = -3047.5932617188, ['y'] = 585.78741455078, ['z'] = 7.9089283943176 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (15/20)",
		lastrobbed = 0
	},
	["7/11 (16/20)"] = {
		mincops = 2,
		position = { ['x'] = -1827.0748291016, ['y'] = 798.49713134766, ['z'] = 138.15504455566 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (16/20)",
		lastrobbed = 0
	},
	["7/11 (17/20)"] = {
		mincops = 2,
		position = { ['x'] = -1482.4875488281, ['y'] = -376.6328125, ['z'] = 40.163425445557 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (17/20)",
		lastrobbed = 0
	},
	["7/11 (18/20)"] = {
		mincops = 2,
		position = { ['x'] = -1221.4212646484, ['y'] = -912.03363037109, ['z'] = 12.326355934143 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (18/20)",
		lastrobbed = 0
	},
	["7/11 (19/20)"] = {
		mincops = 2,
		position = { ['x'] = -709.01837158203, ['y'] = -905.25793457031, ['z'] = 19.215587615967 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (19/20)",
		lastrobbed = 0
	},
	["7/11 (20/20)"] = {
		mincops = 2,
		position = { ['x'] = -709.01837158203, ['y'] = -905.25793457031, ['z'] = 19.215587615967 },
		reward = math.random(20000,60000),
		nameofbank = "7/11 (20/20)",
		lastrobbed = 0
	},
	["Danmarks Nationalbank"] = {
		mincops = 5,
		position = { ['x'] = 255.001098632813, ['y'] = 225.855895996094, ['z'] = 101.005694274902 },
		reward = math.random(400000,600000),
		nameofbank = "Danmarks Nationalbank (Downtown Vinewood)",
		lastrobbed = 0
	}
}