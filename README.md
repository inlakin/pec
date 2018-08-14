# PEC
## Privilege Escalation Checker

### Content

This repository contains several scripts I used during my OSCP journey for enumerating a target once I've obtained a first foothold on the target.

### Windows: ###
#### wipec.bat #### 

[X] OS Info  
[X] User Info  
[X] Admin Info  
[X] Networking Info  
[X] Active connections  
[X] Firewall Information  
[X] Installed Software  
[ ] File Transfer Utilities  
[ ] Vulnerable Services  
TODO with 'sc' (if wmic, and sc are not available, then we can use accesschk. For XP, accesschk v5.2 is needed)
[X] Vulnerable Folder Permissions  
[X] Vulnerable File Permissions  
[X] Vulnerable File Permissions  
[X] Miscellaneous  
[ ] Hotfix checkup  
[ ] List scheduled task  
[ ] List windows services  
[ ] Finding unquoted path  
[ ] Cleartext passwords  
[ ] AlwaysInstallElevated check  
[ ] Listing drivers  
[ ] Kernel Vulnerabilities  


(heavily inspired by [winprivesc](https://github.com/joshruppe/winprivesc))


### Linux: ###
#### lipec.bat ####  

[X] System Info  
[X] Networking Info  
[X] FileSystem Info  
[X] Cron Info  
[X] Users and Environment  
[-] Process and applications   
[X] Tools/Languages for sploit building  
[X] File and Directory Permissions/Contents  

(heavily inspired by [linuxprivchecker](https://github.com/sleventyeleven/linuxprivchecker/blob/master/linuxprivchecker.py))



  
Those tools are not yet finished. 