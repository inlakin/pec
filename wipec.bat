@echo off


echo "--------------------------------------"
echo "                                      "
echo "      Windows Escalation Checker      "
echo "          Robin Desir - 2018          "
echo "                                      "
echo "--------------------------------------"
echo.
echo.
echo.

rem #--------------------------------------------------#
rem #                                                  #
rem #                  Check list                      #
rem #                                                  #
rem # 1. OS Info                                       #
rem # 2. User Info                                     #
rem # 3. Admin Info                                    #
rem # 4. Networking Info                               #
rem # 5. Active connections                            #
rem # 6. Firewall Information                          #
rem # 7. Installed Software                            #
rem # 8. File Transfer Utilities                       # TODO
rem # 9. Vulnerable Services                           # TODO with sc (if wmic, and sc are not available, then we can use accesschk. For XP, accesschk v5.2 is needed)
rem # 10. Vulnerable Folder Permissions                #
rem # 11. Vulnerable File Permissions                  #
rem # 12. Vulnerable File Permissions                  #
rem # 13. Miscellaneous                                #
rem # 14. Hotfix checkup                               # TODO
rem # 15. List scheduled task                          # TODO
rem # 16. List windows services                        # TODO
rem # 17. Finding unquoted path                        # TODO
rem # 18. Cleartext passwords                          # TODO
rem # 19. AlwaysInstallElevated check                  # TODO
rem # 20. Listing drivers                              # TODO
rem # 21. Kernel Vulnerabilities                       # TODO
rem #                                                  # 
rem #                                                  #
rem #--------------------------------------------------#

rem #--------------------------------------------------------------------------------------#
rem #                                                                                      #
rem #                                        Sources                                       #
rem #                                                                                      #
rem # http://www.fuzzysecurity.com/tutorials/16.html                                       #
rem # https://guif.re/windowseop                                                           #
rem # https://github.com/codingo/OSCP-2/blob/master/Windows/WinPrivCheck.bat               #
rem #                                                                                      #
rem #--------------------------------------------------------------------------------------#


if exist ./bin/accesschk.exe (
	set accesschk=1
) else (
	set accesschk=0
)
echo .

echo #--------------#
echo #    OS Info   #
echo #--------------#
echo.
systeminfo | findstr /B /C:"Host Name" /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Domain" 
echo.

echo #---------------#
echo #   User Info   #
echo #---------------#
echo.
whoami || echo %userdomain%\%username% & echo %userprofile%
echo.
net users
echo. 
echo #----------------#
echo #   Admin Info   #
echo #----------------#
echo.
net localgroup administrators
echo.

echo #---------------------#
echo #   Networking info   #
echo #---------------------#
echo.
ipconfig /all & route print & arp -a
echo.

echo #------------------------#
echo #   Active connections   #
echo #------------------------#
echo.
netstat -aton
echo.

echo #--------------------------#
echo #   Firewall information   #
echo #--------------------------#
echo.
netsh firewall show state
netsh firewall show config
echo.

echo #------------------------#
echo #   Installed software   #
echo #------------------------#
echo.

wmic product get Name, Version 
echo.

echo #-----------------------------#
echo #   File Transfer Utilities   #
echo #-----------------------------#
echo.
echo TODO, see rem :)
echo.

rem powershell /? >NUL 2>&1
rem tftp /? >NUL 2>&1
rem wmic /? >NUL 2>&1
rem .\bin\accesschk.exe /? >NUL 2>&1
rem echo %errorlevel%


echo #-------------------------#
echo #   Vulnerable Services   #
echo #-------------------------#
echo.

echo %accesschk%
echo.
if %accesschk%==1 (
	.\bin\accesschk.exe /accepteula -uwcqv "Authenticated Users" * 
	.\bin\accesschk.exe /accepteula -uwcqv "Power Users" *
	.\bin\accesschk.exe /accepteula -uwcqv "Users" *
	
) else (
	echo [!] Skipping, .\bin\accesschk.exe not found.
)
echo.

echo #-----------------------------------#
echo #   Vulnerable Folder Permissions   #
echo #-----------------------------------#
echo.
if %accesschk%==1 (
	.\bin\accesschk.exe /accepteula -uwdqs "Users" c:\
	.\bin\accesschk.exe /accepteula -uwdqs "Authenticated Users" c:\
) else (
	echo [!] Skipping, .\bin\accesschk.exe not found.
)
echo.

echo #---------------------------------#
echo #   Vulnerable File Permissions   #
echo #---------------------------------#
echo.
if %accesschk%==1 (
	.\bin\accesschk.exe /accepteula -uwqs "Users" c:\*.*
	.\bin\accesschk.exe /accepteula -uwqs "Authenticated Users" c:\*.*
) else (
	echo [!] Skipping, .\bin\accesschk.exe not found.
)
echo.

echo #-------------------#
echo #   Miscellaneous   #
echo #-------------------#
echo.
echo If found, the following files need to be checked manually for Administrator password :
echo - c:\sysprep.inf
echo - c:\sysprep\sysprep.xml
echo - %windir%\Panther\Unattend\Unattended.xml
echo - %windir%\Panther\Unattended.xml
echo.

IF EXIST C:/sysprep.inf echo [*] C:\sysprep.inf found.
IF EXIST C:/sysprep/sysprep.xml echo [*] C:\sysprep\sysprep.xml found.
IF EXIST %windir%/Panther/Unattend/Unattended.xml echo [*] %windir%\Panther\Unattend\Unattended.xml found.
IF EXIST %windir%/Panther/Unattend.xml echo [*] %windir%\Panther\Unattend.xml found.
echo.

echo.
echo Exiting.