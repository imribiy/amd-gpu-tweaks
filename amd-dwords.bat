@echo off
setlocal EnableDelayedExpansion

openfiles >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Requesting Administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

::Made by imribiy
::Last updated 12.25.2025
::https://github.com/imribiy/amd-gpu-tweaks

echo
echo       AMD RADEON TWEAKS
echo
echo.

set "base=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
set "target="

for /f "tokens=*" %%A in ('reg query "%base%" /k /f "*" ^| findstr /r "\\....$"') do (
    reg query "%%A" /v "ProviderName" 2>nul | find /i "Advanced Micro Devices, Inc." >nul
    if !errorlevel! equ 0 (
        set "target=%%A"
        echo [OK] Found AMD GPU at: %%A
        goto :tweaks
    )
)

echo [ERROR] Could not find any AMD GPUs.
echo Aborting to prevent damage to non-AMD devices.
echo If you have AMD GPU but this script failed, try to reinstall your GPU drivers.
pause
exit /b

:tweaks

reg add "%target%" /v "ReportAnalytics" /t REG_DWORD /d 0 /f
reg add "%target%" /v "NotifySubscription" /t REG_DWORD /d 0 /f
reg add "%target%" /v "AllowSubscription" /t REG_DWORD /d 0 /f
reg add "%target%" /v "ShowReleaseNotes" /t REG_DWORD /d 0 /f
reg add "%target%" /v "ECCMode" /t REG_DWORD /d 0 /f

reg add "%target%" /v "StutterMode" /t REG_DWORD /d 0 /f
reg add "%target%" /v "DisableLTR" /t REG_DWORD /d 1 /f
reg add "%target%" /v "BGM_EnableLTR" /t REG_DWORD /d 0 /f
reg add "%target%" /v "PP_EnableDynamicLTRSupport" /t REG_DWORD /d 0 /f
reg add "%target%" /v "KMD_EnableAmdFendrOptions" /t REG_DWORD /d 0 /f
reg add "%target%" /v "KMD_ChillEnabled" /t REG_DWORD /d 0 /f
reg add "%target%" /v "KMD_DeLagEnabled" /t REG_DWORD /d 1 /f
reg add "%target%" /v "KMD_FramePacingSupport" /t REG_DWORD /d 0 /f
reg add "%target%" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d 0 /f
reg add "%target%" /v "DalDisableStutter" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableBlockWrite" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableFBCSupport" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableFBCForFullScreenApp" /t REG_DWORD /d 1 /f

reg add "%target%" /v "PP_Force3DPerformanceMode" /t REG_DWORD /d 1 /f
reg add "%target%" /v "PP_ForceHighDPMLevel" /t REG_DWORD /d 1 /f
reg add "%target%" /v "PP_SclkDeepSleepDisable" /t REG_DWORD /d 1 /f
reg add "%target%" /v "PP_GfxOffControl" /t REG_DWORD /d 0 /f
reg add "%target%" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d 0 /f
reg add "%target%" /v "PP_EnableRaceToIdle" /t REG_DWORD /d 0 /f
reg add "%target%" /v "PP_SclkDpmDisabled" /t REG_DWORD /d 1 /f
reg add "%target%" /v "PP_MclkDpmDisabled" /t REG_DWORD /d 1 /f
reg add "%target%" /v "PP_SocclkDpmDisabled" /t REG_DWORD /d 1 /f
reg add "%target%" /v "PP_PcieDpmDisabled" /t REG_DWORD /d 1 /f

reg add "%target%" /v "EnableUlps" /t REG_DWORD /d 0 /f
reg add "%target%" /v "EnableUlps_NA" /t REG_SZ /d "0" /f
reg add "%target%" /v "PP_DisableULPS" /t REG_DWORD /d 1 /f
reg add "%target%" /v "KMD_EnableULPS" /t REG_DWORD /d 0 /f
reg add "%target%" /v "KMD_ForceD3ColdSupport" /t REG_DWORD /d 0 /f

reg add "%target%" /v "EnableAspmL0s" /t REG_DWORD /d 0 /f
reg add "%target%" /v "EnableAspmL1" /t REG_DWORD /d 0 /f
reg add "%target%" /v "EnableAspmL1SS" /t REG_DWORD /d 0 /f
reg add "%target%" /v "DisableAspmL0s" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableAspmL1" /t REG_DWORD /d 1 /f

reg add "%target%" /v "DisableGfxClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableAllClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableSysClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableVceClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableSamuClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableRomMGCGClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGfxCoarseGrainClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGfxMediumGrainClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGfxFineGrainClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableHdpMGClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGfxMGCG" /t REG_DWORD /d 1 /f
reg add "%target%" /v "EnableVceSwClockGating" /t REG_DWORD /d 0 /f
reg add "%target%" /v "EnableUvdClockGating" /t REG_DWORD /d 0 /f
reg add "%target%" /v "EnableGfxClockGatingThruSmu" /t REG_DWORD /d 0 /f
reg add "%target%" /v "EnableSysClockGatingThruSmu" /t REG_DWORD /d 0 /f

reg add "%target%" /v "DisableGfxMGLS" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableHdpClockPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGmcPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableSDMAPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableSAMUPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableUVDPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableVCEPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableAcpPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGfxCGPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableStaticGfxMGPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableDynamicGfxMGPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableCpPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGDSPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableXdmaPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGFXPipelinePowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableQuickGfxMGPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisablePowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGDSPowerGating" /t REG_DWORD /d 1 /f

reg add "%target%" /v "SMU_DisableMmhubPowerGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "SMU_DisableAthubPowerGating" /t REG_DWORD /d 1 /f

reg add "%target%" /v "DalForceMaxDisplayClock" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DalDisableClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DalDisableDeepSleep" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DalDisableDiv2" /t REG_DWORD /d 1 /f

reg add "%target%" /v "EnableSpreadSpectrum" /t REG_DWORD /d 0 /f


set "Root=HKLM\System\CurrentControlSet\Services"

for %%S in ("AMD Crash Defender Service" "amdfendr" "amdfendrmgr" "amdlog") do (
    reg query "%Root%\%%~S" >nul 2>&1 && Reg add "%Root%\%%~S" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)


:: MPO Fix (Global DWM Key)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f

echo.
echo =========================================================
echo SUCCESS: All optimizations applied.
echo You must RESTART your PC for changes to take effect.
echo =========================================================
pause



