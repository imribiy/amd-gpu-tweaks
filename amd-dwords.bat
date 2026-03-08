@echo off
setlocal EnableDelayedExpansion

openfiles >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Requesting Administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

::Made by imribiy
::Last updated 02/27/2026
::https://github.com/imribiy/amd-gpu-tweaks

echo.
echo       AMD RADEON TWEAKS
echo.
echo   [1] Apply
echo   [2] Revert
echo.

choice /c 12 /n /m "Select option: "
set "choice=%errorlevel%"
if "%choice%"=="2" goto :find_gpu_revert
if "%choice%"=="1" goto :find_gpu_apply

:find_gpu_apply
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

:find_gpu_revert
set "base=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
set "target="

for /f "tokens=*" %%A in ('reg query "%base%" /k /f "*" ^| findstr /r "\\....$"') do (
    reg query "%%A" /v "ProviderName" 2>nul | find /i "Advanced Micro Devices, Inc." >nul
    if !errorlevel! equ 0 (
        set "target=%%A"
        echo [OK] Found AMD GPU at: %%A
        goto :revert
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
::reg add "%target%" /v "ECCMode" /t REG_DWORD /d 0 /f

reg add "%target%" /v "StutterMode" /t REG_DWORD /d 0 /f
::reg add "%target%" /v "DisableLTR" /t REG_DWORD /d 1 /f
::reg add "%target%" /v "BGM_EnableLTR" /t REG_DWORD /d 0 /f
::reg add "%target%" /v "PP_EnableDynamicLTRSupport" /t REG_DWORD /d 0 /f
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
::reg add "%target%" /v "PP_SclkDpmDisabled" /t REG_DWORD /d 1 /f
::reg add "%target%" /v "PP_MclkDpmDisabled" /t REG_DWORD /d 1 /f
::reg add "%target%" /v "PP_SocclkDpmDisabled" /t REG_DWORD /d 1 /f
::reg add "%target%" /v "PP_PcieDpmDisabled" /t REG_DWORD /d 1 /f

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
::reg add "%target%" /v "DisableAllClockGating" /t REG_DWORD /d 1 /f
::reg add "%target%" /v "DisableSysClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableVceClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableSamuClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableRomMGCGClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGfxCoarseGrainClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGfxMediumGrainClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableGfxFineGrainClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableHdpMGClockGating" /t REG_DWORD /d 1 /f
::reg add "%target%" /v "DisableGfxMGCG" /t REG_DWORD /d 1 /f
reg add "%target%" /v "EnableVceSwClockGating" /t REG_DWORD /d 0 /f
reg add "%target%" /v "EnableUvdClockGating" /t REG_DWORD /d 0 /f
reg add "%target%" /v "EnableGfxClockGatingThruSmu" /t REG_DWORD /d 0 /f
reg add "%target%" /v "EnableSysClockGatingThruSmu" /t REG_DWORD /d 0 /f
reg add "%target%" /v "DisableXdmaSclkGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DalFineGrainClockGating" /t REG_DWORD /d 0 /f
reg add "%target%" /v "DisableRomMediumGrainClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableNbioMediumGrainClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableMcMediumGrainClockGating" /t REG_DWORD /d 1 /f
reg add "%target%" /v "IRQMgrDisableIHClockGating" /t REG_DWORD /d 1 /f

reg add "%target%" /v "DisableGfxMGLS" /t REG_DWORD /d 1 /f
reg add "%target%" /v "DisableHdpClockPowerGating" /t REG_DWORD /d 1 /f
::reg add "%target%" /v "DisableGmcPowerGating" /t REG_DWORD /d 1 /f
::reg add "%target%" /v "DisableSDMAPowerGating" /t REG_DWORD /d 1 /f
::reg add "%target%" /v "DisableSAMUPowerGating" /t REG_DWORD /d 1 /f
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
reg add "%target%" /v "EnableVcePllSpreadSpectrum" /t REG_DWORD /d 0 /f

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
exit /b

:revert

reg delete "%target%" /v "ReportAnalytics" /f >nul 2>&1
reg delete "%target%" /v "NotifySubscription" /f >nul 2>&1
reg delete "%target%" /v "AllowSubscription" /f >nul 2>&1
reg delete "%target%" /v "ShowReleaseNotes" /f >nul 2>&1

reg delete "%target%" /v "StutterMode" /f >nul 2>&1
reg delete "%target%" /v "KMD_EnableAmdFendrOptions" /f >nul 2>&1
reg delete "%target%" /v "KMD_ChillEnabled" /f >nul 2>&1
reg delete "%target%" /v "KMD_DeLagEnabled" /f >nul 2>&1
reg delete "%target%" /v "KMD_FramePacingSupport" /f >nul 2>&1
reg delete "%target%" /v "KMD_RadeonBoostEnabled" /f >nul 2>&1
reg delete "%target%" /v "DalDisableStutter" /f >nul 2>&1
reg delete "%target%" /v "DisableBlockWrite" /f >nul 2>&1
reg delete "%target%" /v "DisableFBCSupport" /f >nul 2>&1
reg delete "%target%" /v "DisableFBCForFullScreenApp" /f >nul 2>&1

reg delete "%target%" /v "PP_Force3DPerformanceMode" /f >nul 2>&1
reg delete "%target%" /v "PP_ForceHighDPMLevel" /f >nul 2>&1
reg delete "%target%" /v "PP_SclkDeepSleepDisable" /f >nul 2>&1
reg delete "%target%" /v "PP_GfxOffControl" /f >nul 2>&1
reg delete "%target%" /v "PP_ThermalAutoThrottlingEnable" /f >nul 2>&1
reg delete "%target%" /v "PP_EnableRaceToIdle" /f >nul 2>&1

reg delete "%target%" /v "EnableUlps" /f >nul 2>&1
reg delete "%target%" /v "EnableUlps_NA" /f >nul 2>&1
reg delete "%target%" /v "PP_DisableULPS" /f >nul 2>&1
reg delete "%target%" /v "KMD_EnableULPS" /f >nul 2>&1
reg delete "%target%" /v "KMD_ForceD3ColdSupport" /f >nul 2>&1

reg delete "%target%" /v "EnableAspmL0s" /f >nul 2>&1
reg delete "%target%" /v "EnableAspmL1" /f >nul 2>&1
reg delete "%target%" /v "EnableAspmL1SS" /f >nul 2>&1
reg delete "%target%" /v "DisableAspmL0s" /f >nul 2>&1
reg delete "%target%" /v "DisableAspmL1" /f >nul 2>&1

reg delete "%target%" /v "DisableGfxClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableVceClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableSamuClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableRomMGCGClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableGfxCoarseGrainClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableGfxMediumGrainClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableGfxFineGrainClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableHdpMGClockGating" /f >nul 2>&1
reg delete "%target%" /v "EnableVceSwClockGating" /f >nul 2>&1
reg delete "%target%" /v "EnableUvdClockGating" /f >nul 2>&1
reg delete "%target%" /v "EnableGfxClockGatingThruSmu" /f >nul 2>&1
reg delete "%target%" /v "EnableSysClockGatingThruSmu" /f >nul 2>&1
reg delete "%target%" /v "DisableXdmaSclkGating" /f >nul 2>&1
reg delete "%target%" /v "DalFineGrainClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableRomMediumGrainClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableNbioMediumGrainClockGating" /f >nul 2>&1
reg delete "%target%" /v "DisableMcMediumGrainClockGating" /f >nul 2>&1
reg delete "%target%" /v "IRQMgrDisableIHClockGating" /f >nul 2>&1

reg delete "%target%" /v "DisableGfxMGLS" /f >nul 2>&1
reg delete "%target%" /v "DisableHdpClockPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableUVDPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableVCEPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableAcpPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableDrmdmaPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableGfxCGPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableStaticGfxMGPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableDynamicGfxMGPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableCpPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableGDSPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableXdmaPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableGFXPipelinePowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisableQuickGfxMGPowerGating" /f >nul 2>&1
reg delete "%target%" /v "DisablePowerGating" /f >nul 2>&1

reg delete "%target%" /v "SMU_DisableMmhubPowerGating" /f >nul 2>&1
reg delete "%target%" /v "SMU_DisableAthubPowerGating" /f >nul 2>&1

reg delete "%target%" /v "DalForceMaxDisplayClock" /f >nul 2>&1
reg delete "%target%" /v "DalDisableClockGating" /f >nul 2>&1
reg delete "%target%" /v "DalDisableDeepSleep" /f >nul 2>&1
reg delete "%target%" /v "DalDisableDiv2" /f >nul 2>&1

reg delete "%target%" /v "EnableSpreadSpectrum" /f >nul 2>&1
reg delete "%target%" /v "EnableVcePllSpreadSpectrum" /f >nul 2>&1

set "Root=HKLM\System\CurrentControlSet\Services"

for %%S in ("AMD Crash Defender Service" "amdfendr" "amdfendrmgr" "amdlog") do (
    reg query "%Root%\%%~S" >nul 2>&1 && Reg add "%Root%\%%~S" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1
)

:: MPO Fix (Global DWM Key)
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /f >nul 2>&1

echo.
echo =========================================================
echo SUCCESS: All tweaks reverted.
echo You must RESTART your PC for changes to take effect.
echo =========================================================
pause
