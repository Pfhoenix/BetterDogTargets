return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`BetterDogTargets` encountered an error loading the Darktide Mod Framework.")

		new_mod("BetterDogTargets", {
			mod_script       = "BetterDogTargets/scripts/mods/BetterDogTargets/BetterDogTargets",
			mod_data         = "BetterDogTargets/scripts/mods/BetterDogTargets/BetterDogTargets_data",
			mod_localization = "BetterDogTargets/scripts/mods/BetterDogTargets/BetterDogTargets_localization",
		})
	end,
	packages = {},
}
