#!/bin/bash
	
	osvers=$(sw_vers -productVersion | awk -F. '{print $2}')
	osversfull=$(sw_vers -productVersion)
	
	if [ "${osvers}" -eq "12" ]; then
		
		susdownload="http://audiocontentdownload.apple.com/lp10_ms3_content_2016"
		tmp="/private/var/tmp"
		
		pkg=(
			'MAContent10_AssetPack_0539_DrummerTambourine.pkg'
			'MAContent10_AssetPack_0324_AppleLoopsBluesGarage.pkg'
			'MAContent10_AssetPack_0536_DrummerClapsCowbell.pkg'
			'MAContent10_AssetPack_0322_AppleLoopsDiscoFunk1.pkg'
			'MAContent10_AssetPack_0315_AppleLoopsElectroHouse1.pkg'
			'MAContent10_AssetPack_0593_DrummerSoCalGBLogic.pkg'
			'MAContent10_AssetPack_0320_AppleLoopsChillwave1.pkg'
			'MAContent10_AssetPack_0646_AppleLoopsDrummerElectronic.pkg'
			'MAContent10_AssetPack_0375_EXS_GuitarsVintageStrat.pkg'
			'MAContent10_AssetPack_0316_AppleLoopsDubstep1.pkg'
			'MAContent10_AssetPack_0597_LTPChordTrainer.pkg'
			'MAContent10_AssetPack_0509_EXS_StringsEnsemble.pkg'
			'MAContent10_AssetPack_0484_EXS_OrchWoodwindClarinetSolo.pkg'
			'MAContent10_AssetPack_0554_AppleLoopsDiscoFunk2.pkg'
			'MAContent10_AssetPack_0358_EXS_BassElectricFingerStyle.pkg'
			'MAContent10_AssetPack_0540_PlugInSettingsGB.pkg'
			'MAContent10_AssetPack_0371_EXS_GuitarsAcoustic.pkg'
			'MAContent10_AssetPack_0537_DrummerShaker.pkg'
			'MAContent10_AssetPack_0323_AppleLoopsVintageBreaks.pkg'
			'MAContent10_AssetPack_0048_AlchemyPadsDigitalHolyGhost.pkg'
			'MAContent10_AssetPack_0317_AppleLoopsModernRnB1.pkg'
			'MAContent10_AssetPack_0487_EXS_OrchWoodwindFluteSolo.pkg'
			'MAContent10_AssetPack_0314_AppleLoopsHipHop1.pkg'
			'MAContent10_AssetPack_0482_EXS_OrchWoodwindAltoSax.pkg'
			'MAContent10_AssetPack_0538_DrummerSticks.pkg'
			'MAContent10_AssetPack_0325_AppleLoopsGarageBand1.pkg'
			'MAContent10_AssetPack_0354_EXS_PianoSteinway.pkg'
			'MAContent10_AssetPack_0491_EXS_OrchBrass.pkg'
			'MAContent10_AssetPack_0598_LTPBasicGuitar1.pkg'
			'MAContent10_AssetPack_0541_PlugInSettingsGBLogic.pkg'
			'MAContent10_AssetPack_0321_AppleLoopsIndieDisco.pkg'
			'MAContent10_AssetPack_0615_GBLogicAlchemyEssentials.pkg'
			'MAContent10_AssetPack_0637_AppleLoopsDrummerKyle.pkg'
			'MAContent10_AssetPack_0560_LTPBasicPiano1.pkg'
			'MAContent10_AssetPack_0310_UB_DrumMachineDesignerGB.pkg'
			'MAContent10_AssetPack_0357_EXS_BassAcousticUprightJazz.pkg'
			'MAContent10_AssetPack_0312_UB_UltrabeatKitsGBLogic.pkg'
		)
		
		for ((i = 0; i < "${#pkg[@]}"; i++)); do
			cd "${tmp}"
			/usr/bin/curl -O -J -L "${susdownload}"/"${pkg[$i]}"
			cd
			installer -pkg "${tmp}"/"${pkg[$i]}" -target /
		done
		
	else
		
		echo "This loops are not compatible with macOS ${osversfull}"
		
	fi
	
exit 0