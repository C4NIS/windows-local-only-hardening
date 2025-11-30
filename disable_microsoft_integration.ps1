# -----------------------------
# WINDOWS 11 - LOCAL ONLY MODE
# Remove SSO, desativa integração Microsoft, OneDrive, Telemetria,
# Identidade na nuvem e sincronização automática.
# -----------------------------

Write-Host "===> Desativando Single Sign-On (SSO)..."
reg add "HKLM\SOFTWARE\Microsoft\IdentityStore" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\IdentityStore\Logon" /v Enabled /t REG_DWORD /d 0 /f

Write-Host "===> Removendo Web Account Manager..."
sc stop tokenbroker
sc config tokenbroker start= disabled

Write-Host "===> Desativando 'Shared Experiences'..."
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" /v CdpSessionUserAuthzPolicy /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" /v NearShareChannelAuthzPolicy /t REG_DWORD /d 0 /f

Write-Host "===> Bloqueando login automático em apps..."
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f

Write-Host "===> Limpando tokens de identidade..."
cmdkey /delete:WindowsLive:target=virtualapp/didlogical >$null 2>&1
cmdkey /list

Write-Host "===> Removendo OneDrive completamente..."
taskkill /f /im OneDrive.exe
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
%SystemRoot%\System32\OneDriveSetup.exe /uninstall

Write-Host "===> Desativando Telemetria pesada..."
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

Write-Host "===> Desativando tarefas agendadas de telemetria..."
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable

Write-Host "===> Bloqueando sincronização de conta Microsoft..."
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSync /t REG_DWORD /d 2 /f

Write-Host "===> Desativando Timeline e Cloud Clipboard..."
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowRecentFiles /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Clipboard" /v EnableClipboardHistory /t REG_DWORD /d 0 /f

Write-Host "===> Forçando login local apenas..."
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v NoConnectedUser /t REG_DWORD /d 3 /f

##
# parar o serviço agora
Stop-Service -Name TokenBroker -Force

# desativar no boot
Set-Service -Name TokenBroker -StartupType Disabled


Write-Host "===> PRONTO! Windows agora está no modo local puro."
Write-Host "Reinicie o sistema."

