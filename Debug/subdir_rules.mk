################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
CC2650STK.obj: ../CC2650STK.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/bin/armcl" -mv7M3 --code_state=16 --float_support=vfplib -me --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/easylink" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/smartrf_settings" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/sce" --include_path="C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/cc26xxware_2_24_03_17272" --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/include" --define=ccs -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="CC2650STK.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

NodeRadioTask.obj: ../NodeRadioTask.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/bin/armcl" -mv7M3 --code_state=16 --float_support=vfplib -me --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/easylink" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/smartrf_settings" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/sce" --include_path="C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/cc26xxware_2_24_03_17272" --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/include" --define=ccs -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="NodeRadioTask.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

NodeTask.obj: ../NodeTask.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/bin/armcl" -mv7M3 --code_state=16 --float_support=vfplib -me --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/easylink" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/smartrf_settings" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/sce" --include_path="C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/cc26xxware_2_24_03_17272" --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/include" --define=ccs -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="NodeTask.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

PersonlizationTask.obj: ../PersonlizationTask.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/bin/armcl" -mv7M3 --code_state=16 --float_support=vfplib -me --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/easylink" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/smartrf_settings" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/sce" --include_path="C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/cc26xxware_2_24_03_17272" --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/include" --define=ccs -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="PersonlizationTask.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

SceAdc.obj: ../SceAdc.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/bin/armcl" -mv7M3 --code_state=16 --float_support=vfplib -me --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/easylink" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/smartrf_settings" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/sce" --include_path="C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/cc26xxware_2_24_03_17272" --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/include" --define=ccs -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="SceAdc.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

ccfg.obj: ../ccfg.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/bin/armcl" -mv7M3 --code_state=16 --float_support=vfplib -me --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/easylink" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/smartrf_settings" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/sce" --include_path="C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/cc26xxware_2_24_03_17272" --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/include" --define=ccs -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="ccfg.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

build-1576607375:
	@$(MAKE) --no-print-directory -Onone -f subdir_rules.mk build-1576607375-inproc

build-1576607375-inproc: ../rfExamples.cfg
	@echo 'Building file: $<'
	@echo 'Invoking: XDCtools'
	"C:/ti/xdctools_3_32_00_06_core/xs" --xdcpath="C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/packages;C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/tidrivers_cc13xx_cc26xx_2_21_00_04/packages;C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/bios_6_46_01_37/packages;C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/uia_2_01_00_01/packages;C:/ti/ccsv7/ccs_base;" xdc.tools.configuro -o configPkg -t ti.targets.arm.elf.M3 -p ti.platforms.simplelink:CC2650F128 -r release -c "C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS" --compileOptions "-mv7M3 --code_state=16 --float_support=vfplib -me --include_path=\"C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch\" --include_path=\"C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/easylink\" --include_path=\"C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/smartrf_settings\" --include_path=\"C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/sce\" --include_path=\"C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/cc26xxware_2_24_03_17272\" --include_path=\"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/include\" --define=ccs -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi  " "$<"
	@echo 'Finished building: $<'
	@echo ' '

configPkg/linker.cmd: build-1576607375
configPkg/compiler.opt: build-1576607375
configPkg/: build-1576607375

rfWsnNode.obj: ../rfWsnNode.c $(GEN_OPTS) | $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Compiler'
	"C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/bin/armcl" -mv7M3 --code_state=16 --float_support=vfplib -me --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/easylink" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/smartrf_settings" --include_path="C:/Users/arabal/workspace_v7/zrfWsnNode_CC2650_LAUNCHXL_TI_for_SensorTag_Synch/sce" --include_path="C:/ti/tirex-content/tirtos_cc13xx_cc26xx_2_21_00_06/products/cc26xxware_2_24_03_17272" --include_path="C:/ti/ccsv7/tools/compiler/ti-cgt-arm_16.9.0.LTS/include" --define=ccs -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --abi=eabi --preproc_with_compile --preproc_dependency="rfWsnNode.d" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


