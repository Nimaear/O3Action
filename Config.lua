local addon, ns = ...

ns.config = {
	mainBar = {
		paging = true,
	},
	cooldownBar = {
		columns = 12,
		rows = 2,
		buttonWidth = 30,
		buttonHeight = 30,
		spacing = 4,
	},
	petBar = {
		columns = 10,
		rows = 1,
		buttonWidth = 30,
		buttonHeight = 30,
		spacing = 4,
	},
	leftSplitBar = {
		columns = 6, 
		rows = 2,
		buttonWidth = 30,
		buttonHeight = 30,
	},
	rightSplitBar = {
		columns = 6,
		rows = 2,
		buttonWidth = 30,
		buttonHeight = 30,
	},
	rightBar = {
		columns = 2,
		rows = 12,
		buttonWidth = 30,
		buttonHeight = 30,
		spacing = 2,
	},
	rightBar2 = {
		buttonWidth = 30,
		buttonHeight = 30,
		columns = 3,
		rows = 12,
		spacing = 2,
	},	
	macroBar = {
		columns = 5,
		rows = 1,
		buttonWidth = 30,
		buttonHeight = 30,
		spacing = 2,
	},
	extraBar = {
		buttonWidth = 40,
		buttonHeight = 40,
		columns = 1,
		rows = 1,
	},
	macroText = {
		-- GeneMacroBarButton1 = "",
		-- GeneMacroBarButton2 = "",
		-- GeneMacroBarButton3 = "",
		-- GeneMacroBarButton4 = "",
		-- GeneMacroBarButton5 = "",
	},
	classMacros = {
		rows = 12,
		columns = 2,
		WARRIOR = {

		},
		ROGUE = {},
		MAGE = {},
		PRIEST = {},
		MONK = {
			{
				title = "PA1",
				text = "/cast [@arena1] Paralyze",
				icon = "ability_monk_paralysis",
				bind = "ALT-CTRL-1",
			},
			{
				title = "PA2",
				text = "/cast [@arena2] Paralyze",
				icon = "ability_monk_paralysis",
				bind = "ALT-CTRL-2",
			},
			{
				title = "PA3",
				text = "/cast [@arena3] Paralyze",
				icon = "ability_monk_paralysis",
				bind = "ALT-CTRL-3",
			},
			{
				title = "TL1",
				text = "/cast [@party1] Tiger's Lust",
				icon = "ability_monk_tigerslust",
				bind = "ALT-CTRL-4",
			},
			{
				title = "TL2",
				text = "/cast [@party2] Tiger's Lust",
				icon = "ability_monk_tigerslust",
				bind = "ALT-CTRL-5",
			},
			{
				title = "D1",
				text = "/cast [@party1] Detox",
				icon = "Spell_Holy_DispelMagic",
				bind = "ALT-CTRL-`",
			},
			{
				title = "D2",
				text = "/cast [@party2] Detox",
				icon = "Spell_Holy_DispelMagic",
				bind = "ALT-CTRL-Q",
			},
			{
				title = "RoP1",
				text = "/cast [@party1] Ring of Peace",
				icon = "spell_monk_ringofpeace",
				bind = "ALT-CTRL-E",
			},
			{
				title = "RoP2",
				text = "/cast [@party2] Ring of Peace",
				icon = "spell_monk_ringofpeace",
				bind = "ALT-CTRL-F",
			},
			{
				title = "G1",
				text = "/cast [@arena1] Detox",
				icon = "Ability_Warrior_Disarm",
				bind = "ALT-CTRL-A",
			},
			{
				title = "G2",
				text = "/cast [@arena2] Ring of Peace",
				icon = "Ability_Warrior_Disarm",
				bind = "ALT-CTRL-S",
			},
			{
				title = "G3",
				text = "/cast [@arena3] Ring of Peace",
				icon = "Ability_Warrior_Disarm",
				bind = "ALT-CTRL-D",
			},
			-- Part 2
			{
				title = "PA1",
				text = "/cast [@arena1] Paralyze",
				icon = "ability_monk_paralysis",
				bind = "ALT-SHIFT-1",
			},
			{
				title = "PA2",
				text = "/cast [@arena2] Paralyze",
				icon = "ability_monk_paralysis",
				bind = "ALT-SHIFT-2",
			},
			{
				title = "PA3",
				text = "/cast [@arena3] Paralyze",
				icon = "ability_monk_paralysis",
				bind = "ALT-SHIFT-3",
			},
			{
				title = "TL1",
				text = "/cast [@party1] Tiger's Lust",
				icon = "ability_monk_tigerslust",
				bind = "ALT-SHIFT-4",
			},
			{
				title = "TL2",
				text = "/cast [@party2] Tiger's Lust",
				icon = "ability_monk_tigerslust",
				bind = "ALT-SHIFT-5",
			},
			{
				title = "D1",
				text = "/cast [@party1] Detox",
				icon = "Spell_Holy_DispelMagic",
				bind = "ALT-SHIFT-`",
			},
			{
				title = "D2",
				text = "/cast [@party2] Detox",
				icon = "Spell_Holy_DispelMagic",
				bind = "ALT-SHIFT-Q",
			},
			{
				title = "RoP1",
				text = "/cast [@party1] Ring of Peace",
				icon = "spell_monk_ringofpeace",
				bind = "ALT-SHIFT-E",
			},
			{
				title = "RoP2",
				text = "/cast [@party2] Ring of Peace",
				icon = "spell_monk_ringofpeace",
				bind = "ALT-SHIFT-F",
			},
			{
				title = "G1",
				text = "/cast [@arena1] Detox",
				icon = "Ability_Warrior_Disarm",
				bind = "ALT-SHIFT-A",
			},
			{
				title = "G2",
				text = "/cast [@arena2] Ring of Peace",
				icon = "Ability_Warrior_Disarm",
				bind = "ALT-SHIFT-S",
			},
			{
				title = "G3",
				text = "/cast [@arena3] Ring of Peace",
				icon = "Ability_Warrior_Disarm",
				bind = "ALT-SHIFT-D",
			},
		},
		HUNTER = {
			{
				title = "SS1",
				text = "/cast [@arena1] Scatter Shot",
				icon = "Ability_GolemStormBolt",
				bind = "ALT-CTRL-1",
			},
			{
				title = "SS2",
				text = "/cast [@arena2] Scatter Shot",
				icon = "Ability_GolemStormBolt",
				bind = "ALT-CTRL-2",
			},
			{
				title = "SS3",
				text = "/cast [@arena3] Scatter Shot",
				icon = "Ability_GolemStormBolt",
				bind = "ALT-CTRL-3",
			},
			{
				title = "MC1",
				text = "/cast [@party1] Master's Call",
				icon = "Ability_Hunter_MastersCall",
				bind = "ALT-CTRL-4",
			},
			{
				title = "MC2",
				text = "/cast [@party2] Master's Call",
				icon = "Ability_Hunter_MastersCall",
				bind = "ALT-CTRL-5",
			},
			{
				title = "RoS1",
				text = "/cast [@party1] Roar of Sacrifice",
				icon = "ability_hunter_fervor",
				bind = "ALT-CTRL-`",
			},
			{
				title = "RoS2",
				text = "/cast [@party2] Roar of Sacrifice",
				icon = "ability_hunter_fervor",
				bind = "ALT-CTRL-Q",
			},
			{
				title = "RoP1",
				text = "/cast [@party1] Ring of Peace",
				icon = "spell_monk_ringofpeace",
				bind = "ALT-CTRL-E",
			},
			{
				title = "RoP2",
				text = "/cast [@party2] Ring of Peace",
				icon = "spell_monk_ringofpeace",
				bind = "ALT-CTRL-F",
			},
			{
				title = "SB1",
				text = "/cast [@arena1] Scare Beast",
				icon = "Ability_Druid_Cower",
				bind = "ALT-CTRL-A",
			},
			{
				title = "SB2",
				text = "/cast [@arena2] Scare Beast",
				icon = "Ability_Druid_Cower",
				bind = "ALT-CTRL-S",
			},
			{
				title = "SB3",
				text = "/cast [@arena3] Scare Beast",
				icon = "Ability_Druid_Cower",
				bind = "ALT-CTRL-D",
			},
			-- Part 2
			{
				title = "HM1",
				text = "/cast [@arena1] Hunter's Mark",
				icon = "Ability_Hunter_SniperShot",
				bind = "ALT-SHIFT-1",
			},
			{
				title = "HM2",
				text = "/cast [@arena2] Hunter's Mark",
				icon = "Ability_Hunter_SniperShot",
				bind = "ALT-SHIFT-2",
			},
			{
				title = "HM3",
				text = "/cast [@arena3] Hunter's Mark",
				icon = "Ability_Hunter_SniperShot",
				bind = "ALT-SHIFT-3",
			},
			{
				title = "TL1",
				text = "/cast [@party1] Tiger's Lust",
				icon = "ability_monk_tigerslust",
				bind = "ALT-SHIFT-4",
			},
			{
				title = "TL2",
				text = "/cast [@party2] Tiger's Lust",
				icon = "ability_monk_tigerslust",
				bind = "ALT-SHIFT-5",
			},
			{
				title = "D1",
				text = "/cast [@party1] Detox",
				icon = "Spell_Holy_DispelMagic",
				bind = "ALT-SHIFT-`",
			},
			{
				title = "D2",
				text = "/cast [@party2] Detox",
				icon = "Spell_Holy_DispelMagic",
				bind = "ALT-SHIFT-Q",
			},
			{
				title = "RoS1",
				text = "/cast [@player] Roar of Sacrifice",
				icon = "ability_hunter_fervor",
				bind = "ALT-SHIFT-E",
			},
			{
				title = "RoP2",
				text = "/cast [@party2] Roar of Sacrifice",
				icon = "ability_hunter_fervor",
				bind = "ALT-SHIFT-F",
			},
			{
				title = "T1",
				text = "/cast [@arena1] Tranquilizing Shot",
				icon = "Spell_Nature_Drowsy",
				bind = "ALT-SHIFT-A",
			},
			{
				title = "T2",
				text = "/cast [@arena2] Tranquilizing Shot",
				icon = "Spell_Nature_Drowsy",
				bind = "ALT-SHIFT-S",
			},
			{
				title = "T3",
				text = "/cast [@arena3] Tranquilizing Shot",
				icon = "Spell_Nature_Drowsy",
				bind = "ALT-SHIFT-D",
			},
		},
		WARLOCK = {
		},
		DEATHKNIGHT = {
			{
				title = "SS1",
				text = "/cast [@arena1] Scatter Shot",
				icon = "Ability_GolemStormBolt",
				bind = "ALT-CTRL-1",
			},
			{
				title = "SS2",
				text = "/cast [@arena2] Scatter Shot",
				icon = "Ability_GolemStormBolt",
				bind = "ALT-CTRL-2",
			},
			{
				title = "SS3",
				text = "/cast [@arena3] Scatter Shot",
				icon = "Ability_GolemStormBolt",
				bind = "ALT-CTRL-3",
			},
			{
				title = "MC1",
				text = "/cast [@party1] Master's Call",
				icon = "Ability_Hunter_MastersCall",
				bind = "ALT-CTRL-4",
			},
			{
				title = "MC2",
				text = "/cast [@party2] Master's Call",
				icon = "Ability_Hunter_MastersCall",
				bind = "ALT-CTRL-5",
			},
			{
				title = "RoS1",
				text = "/cast [@party1] Roar of Sacrifice",
				icon = "ability_hunter_fervor",
				bind = "ALT-CTRL-`",
			},
			{
				title = "RoS2",
				text = "/cast [@party2] Roar of Sacrifice",
				icon = "ability_hunter_fervor",
				bind = "ALT-CTRL-Q",
			},
			{
				title = "RoP1",
				text = "/cast [@party1] Ring of Peace",
				icon = "spell_monk_ringofpeace",
				bind = "ALT-CTRL-E",
			},
			{
				title = "RoP2",
				text = "/cast [@party2] Ring of Peace",
				icon = "spell_monk_ringofpeace",
				bind = "ALT-CTRL-F",
			},
			{
				title = "Sim1",
				text = "/cast [@arena1] Dark Simulacrum",
				icon = "Spell_Holy_ConsumeMagic",
				bind = "ALT-CTRL-A",
			},
			{
				title = "Sim2",
				text = "/cast [@arena2] Dark Simulacrum",
				icon = "Spell_Holy_ConsumeMagic",
				bind = "ALT-CTRL-S",
			},
			{
				title = "Sim3",
				text = "/cast [@arena3] Dark Simulacrum",
				icon = "Spell_Holy_ConsumeMagic",
				bind = "ALT-CTRL-D",
			},
			-- Part 2
			{
				title = "Grip1",
				text = "/cast [@arena1] Death Grip",
				icon = "Spell_DeathKnight_Strangulate",
				bind = "ALT-SHIFT-1",
			},
			{
				title = "Grip2",
				text = "/cast [@arena2] Death Grip",
				icon = "Spell_DeathKnight_Strangulate",
				bind = "ALT-SHIFT-2",
			},
			{
				title = "Grip3",
				text = "/cast [@arena3] Death Grip",
				icon = "Spell_DeathKnight_Strangulate",
				bind = "ALT-SHIFT-3",
			},
			{
				title = "TL1",
				text = "/cast [@party1] Tiger's Lust",
				icon = "ability_monk_tigerslust",
				bind = "ALT-SHIFT-4",
			},
			{
				title = "TL2",
				text = "/cast [@party2] Tiger's Lust",
				icon = "ability_monk_tigerslust",
				bind = "ALT-SHIFT-5",
			},
			{
				title = "D1",
				text = "/cast [@party1] Detox",
				icon = "Spell_Holy_DispelMagic",
				bind = "ALT-SHIFT-`",
			},
			{
				title = "D2",
				text = "/cast [@party2] Detox",
				icon = "Spell_Holy_DispelMagic",
				bind = "ALT-SHIFT-Q",
			},
			{
				title = "RoS1",
				text = "/cast [@player] Roar of Sacrifice",
				icon = "ability_hunter_fervor",
				bind = "ALT-SHIFT-E",
			},
			{
				title = "RoP2",
				text = "/cast [@party2] Roar of Sacrifice",
				icon = "ability_hunter_fervor",
				bind = "ALT-SHIFT-F",
			},
			{
				title = "S1",
				text = "/cast [@arena1] Strangulate",
				icon = "ability_deathknight_asphixiate",
				bind = "ALT-SHIFT-A",
			},
			{
				title = "S2",
				text = "/cast [@arena2] Strangulate",
				icon = "ability_deathknight_asphixiate",
				bind = "ALT-SHIFT-S",
			},
			{
				title = "S3",
				text = "/cast [@arena3] Strangulate",
				icon = "ability_deathknight_asphixiate",
				bind = "ALT-SHIFT-D",
			},		},
		DRUID = {

		},
		PALADIN = {
			{
				title = "SS1",
				text = "/cast [@arena1] Hammer of Justice",
				icon = "Spell_Holy_FistOfJustice",
				bind = "ALT-CTRL-1",
			},
			{
				title = "SS2",
				text = "/cast [@arena2] Hammer of Justice",
				icon = "Spell_Holy_FistOfJustice",
				bind = "ALT-CTRL-2",
			},
			{
				title = "SS3",
				text = "/cast [@arena3] Hammer of Justice",
				icon = "Spell_Holy_FistOfJustice",
				bind = "ALT-CTRL-3",
			},
			{
				title = "MC1",
				text = "/cast [@party1] Hand of Sacrifice",
				icon = "Spell_Holy_SealOfSacrifice",
				bind = "ALT-CTRL-4",
			},
			{
				title = "MC2",
				text = "/cast [@party2] Hand of Sacrifice",
				icon = "Spell_Holy_SealOfSacrifice",
				bind = "ALT-CTRL-5",
			},
			{
				title = "RoS1",
				text = "/cast [@party1] Hand of Protection",
				icon = "Spell_Holy_SealOfProtection",
				bind = "ALT-CTRL-`",
			},
			{
				title = "RoS2",
				text = "/cast [@party2] Hand of Protection",
				icon = "Spell_Holy_SealOfProtection",
				bind = "ALT-CTRL-Q",
			},
			{
				title = "RoP1",
				text = "/cast [@party1] Hand of Freedom",
				icon = "Spell_Holy_SealOfValor",
				bind = "ALT-CTRL-E",
			},
			{
				title = "RoP2",
				text = "/cast [@party2] Hand of Freedom",
				icon = "Spell_Holy_SealOfValor",
				bind = "ALT-CTRL-F",
			},
			{
				title = "SB1",
				text = "/cast [@arena1] Scare Beast",
				--icon = "Ability_Druid_Cower",
				bind = "ALT-CTRL-A",
			},
			{
				title = "SB2",
				text = "/cast [@arena2] Scare Beast",
				--icon = "Ability_Druid_Cower",
				bind = "ALT-CTRL-S",
			},
			{
				title = "SB3",
				text = "/cast [@arena3] Scare Beast",
				--icon = "Ability_Druid_Cower",
				bind = "ALT-CTRL-D",
			},
			-- Part 2
			{
				title = "HM1",
				text = "/cast [@arena1] Turn Evil",
				icon = "ability_paladin_turnevil",
				bind = "ALT-SHIFT-1",
			},
			{
				title = "HM2",
				text = "/cast [@arena2] Turn Evil",
				icon = "ability_paladin_turnevil",
				bind = "ALT-SHIFT-2",
			},
			{
				title = "HM3",
				text = "/cast [@arena3] Turn Evil",
				icon = "ability_paladin_turnevil",
				bind = "ALT-SHIFT-3",
			},
			{
				title = "TL1",
				text = "/cast [@party1] Flash of Light",
				icon = "Spell_Holy_FlashHeal",
				bind = "ALT-SHIFT-4",
			},
			{
				title = "TL2",
				text = "/cast [@party2] Flash of Light",
				icon = "Spell_Holy_FlashHeal",
				bind = "ALT-SHIFT-5",
			},
			{
				title = "D1",
				text = "/cast [@party1] Cleanse",
				icon = "Spell_Holy_Purify",
				bind = "ALT-SHIFT-`",
			},
			{
				title = "D2",
				text = "/cast [@party2] Cleanse",
				icon = "Spell_Holy_Purify",
				bind = "ALT-SHIFT-Q",
			},
			{
				title = "RoS1",
				text = "/cast [@player] Word of Glory",
				icon = "inv_helmet_96",
				bind = "ALT-SHIFT-E",
			},
			{
				title = "RoP2",
				text = "/cast [@party2] Word of Glory",
				icon = "inv_helmet_96",
				bind = "ALT-SHIFT-F",
			},
			{
				title = "T1",
				text = "/cast [@arena1] Tranquilizing Shot",
				--icon = "Spell_Nature_Drowsy",
				bind = "ALT-SHIFT-A",
			},
			{
				title = "T2",
				text = "/cast [@arena2] Tranquilizing Shot",
				--icon = "Spell_Nature_Drowsy",
				bind = "ALT-SHIFT-S",
			},
			{
				title = "T3",
				text = "/cast [@arena3] Tranquilizing Shot",
				--icon = "Spell_Nature_Drowsy",
				bind = "ALT-SHIFT-D",
			},

		},
		SHAMAN = {

		}
	},
	keyBindings = {
		GeneMainBarButton1 = "1",
		GeneMainBarButton2 = "2",
		GeneMainBarButton3 = "3",
		GeneMainBarButton4 = "4",
		GeneMainBarButton5 = "5",
		GeneMainBarButton6 = "`",
		GeneMainBarButton7 = "Q",
		GeneMainBarButton8 = "E",
		GeneMainBarButton9 = "F",
		GeneMainBarButton10 = "V",
		GeneMainBarButton11 = "C",
		GeneMainBarButton12 = "Z",

		GeneRightBar2Button1 = "ALT-1",
		GeneRightBar2Button2 = "ALT-2",
		GeneRightBar2Button3 = "ALT-3",
		GeneRightBar2Button4 = "ALT-4",
		GeneRightBar2Button5 = "ALT-5",
		GeneRightBar2Button6 = "ALT-`",
		GeneRightBar2Button7 = "ALT-Q",
		GeneRightBar2Button8 = "ALT-E",
		GeneRightBar2Button9 = "ALT-F",
		GeneRightBar2Button10 = "ALT-V",
		GeneRightBar2Button11 = "ALT-C",
		GeneRightBar2Button12 = "ALT-Z",

		GeneRightBar2Button13 = "R",
		GeneRightBar2Button14 = "SHIFT-R",
		GeneRightBar2Button15 = "ALT-R",
		GeneRightBar2Button16 = "G",
		GeneRightBar2Button17 = "SHIFT-G",
		GeneRightBar2Button18 = "ALT-G",
		GeneRightBar2Button19 = "T",
		GeneRightBar2Button20 = "SHIFT-T",
		GeneRightBar2Button21 = "ALT-T",
		GeneRightBar2Button22 = "X",
		GeneRightBar2Button23 = "SHIFT-X",
		GeneRightBar2Button24 = "ALT-X",

		GeneRightBar2Button25 = "ALT-W",
		GeneRightBar2Button26 = "ALT-A",
		GeneRightBar2Button27 = "ALT-S",
		GeneRightBar2Button28 = "ALT-D",
		GeneRightBar2Button29 = "SHIFT-W",
		GeneRightBar2Button30 = "SHIFT-A",
		GeneRightBar2Button31 = "SHIFT-S",
		GeneRightBar2Button32 = "SHIFT-D",
		GeneRightBar2Button33 = "CTRL-W",
		GeneRightBar2Button34 = "CTRL-A",
		GeneRightBar2Button35 = "CTRL-S",
		GeneRightBar2Button36 = "CTRL-D",


		GeneRightBarButton1 = "B",
		GeneRightBarButton2 = "SHIFT-B",
		GeneRightBarButton3 = "ALT-B",
		GeneRightBarButton4 = "Y",
		GeneRightBarButton5 = "H",
		GeneRightBarButton6 = "SHIFT-H",
		GeneRightBarButton7 = "SHIFT-Q",
		GeneRightBarButton8 = "SHIFT-E",
		GeneRightBarButton9 = "SHIFT-F",
		GeneRightBarButton10 = "SHIFT-V",
		GeneRightBarButton11 = "SHIFT-C",
		GeneRightBarButton12 = "SHIFT-Z",

		GeneRightBarButton13 = "CTRL-1",
		GeneRightBarButton14 = "CTRL-2",
		GeneRightBarButton15 = "CTRL-3",
		-- GeneRightBarButton4 = "ALT-CTRL-4",
		-- GeneRightBarButton5 = "ALT-CTRL-5",
		-- GeneRightBarButton6 = "ALT-CTRL-`",
		-- GeneRightBarButton7 = "ALT-CTRL-Q",
		-- GeneRightBarButton8 = "ALT-CTRL-W",
		-- GeneRightBarButton9 = "ALT-CTRL-E",
		-- GeneRightBarButton10 = "ALT-CTRL-D",
		-- GeneRightBarButton11 = "ALT-CTRL-S",
		-- GeneRightBarButton12 = "ALT-CTRL-A",
		-- GeneRightBarButton13 = "ALT-SHIFT-1",
		-- GeneRightBarButton14 = "ALT-SHIFT-2",
		-- GeneRightBarButton15 = "ALT-SHIFT-3",
		-- GeneRightBarButton16 = "ALT-SHIFT-4",
		-- GeneRightBarButton17 = "ALT-SHIFT-5",
		-- GeneRightBarButton18 = "ALT-SHIFT-`",
		-- GeneRightBarButton19 = "ALT-SHIFT-Q",
		-- GeneRightBarButton20 = "ALT-SHIFT-W",
		-- GeneRightBarButton21 = "ALT-SHIFT-E",
		-- GeneRightBarButton22 = "ALT-SHIFT-D",
		-- GeneRightBarButton23 = "ALT-SHIFT-S",
		-- GeneRightBarButton24 = "ALT-SHIFT-A",
		-- GeneRightBarButton25 = "B",
		-- GeneRightBarButton26 = "SHIFT-B",
		-- GeneRightBarButton27 = "ALT-B",
		-- GeneRightBarButton28 = "Y",
		-- GeneRightBarButton29 = "H",
		-- GeneRightBarButton30 = "SHIFT-H",
		-- GeneRightBarButton31 = "SHIFT-Q",
		-- GeneRightBarButton32 = "SHIFT-E",
		-- GeneRightBarButton33 = "SHIFT-F",
		-- GeneRightBarButton34 = "SHIFT-V",
		-- GeneRightBarButton35 = "SHIFT-C",
		-- GeneRightBarButton36 = "SHIFT-Z",

		GeneExtraBarButton1 = "CTRL-Q",

		GenePetBarButton1 = "CTRL-1",
		GenePetBarButton2 = "CTRL-2",
		GenePetBarButton3 = "CTRL-3",
		GenePetBarButton4 = "CTRL-4",
		GenePetBarButton5 = "CTRL-5",
		GenePetBarButton6 = "CTRL-`",
		GenePetBarButton7 = "CTRL-E",

		-- GeneMacroBarButton1 = "SHIFT-1",
		-- GeneMacroBarButton2 = "SHIFT-2",
		-- GeneMacroBarButton3 = "SHIFT-3",
		-- GeneMacroBarButton4 = "SHIFT-4",
		-- GeneMacroBarButton5 = "SHIFT-5",
	},
}