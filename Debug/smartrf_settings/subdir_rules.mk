################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
smartrf_settings/smartrf_settings.obj: ../smartrf_settings/smartrf_settings.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/bin/armcl" -mv7M3 --code_state=16 --float_support=vfplib -me --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/easylink" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/smartrf_settings" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/sce" --include_path="C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/cc26xxware_2_24_03_17272" --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/include" --define=ccs -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="smartrf_settings/smartrf_settings.d" --obj_directory="smartrf_settings" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

smartrf_settings/smartrf_settings_predefined.obj: ../smartrf_settings/smartrf_settings_predefined.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/bin/armcl" -mv7M3 --code_state=16 --float_support=vfplib -me --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/easylink" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/smartrf_settings" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/sce" --include_path="C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/cc26xxware_2_24_03_17272" --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/include" --define=ccs -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="smartrf_settings/smartrf_settings_predefined.d" --obj_directory="smartrf_settings" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


