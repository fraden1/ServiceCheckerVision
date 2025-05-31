@echo off
cls

echo.
echo                                   ++++++++                                    
echo                            ++++++++++++++++++++++                             
echo                         +++++++++++++*****+++++++++++                         
echo                      +++++++++**######***######*++++++++                      
echo                   +++++++++*####*+++++++++++++*####*++++++                    
echo                 ++++++++####  +++++++++++++++++++*####*+++++                  
echo               +++++++*##    +++++++*##########*++++#####*++++++               
echo             +++++++*##     ++++++*#    +**######*+++*######*+++++             
echo           +++++++*#       *++++++    ##*++++*#####++++#######++++++           
echo          ++++++*#        **+++++    ###*+++++++####++++ #######*++++          
echo        +++++++#          **++++  **+++++++++++++###*++++  #######+++++        
echo       **++++++          ***++++ ***+++++++++++++*#**++++    ######*++++       
echo       ###*++++++        ****++++**#*++++++++++++****++++      ##*++++++       
echo        ####*++++++       ##*++++*###*+++++++++++****++++     +++++++++        
echo          ####+++++++     ###*++++*####*++++++++ ***+++++    +++++++++         
echo           #####+++++++    ###*+++++########**  **++++++   *++++++++           
echo             #####+++++++   ####++++++          +++++++   +++++++++            
echo                ####*++++++++####*+++++++++++++++++++++++++##*+++              
echo                 #####*++++++++#####*++++++++++++++**+++++++*##                
echo                    #####*+++++++**#####***++**+*###*+++++++++++               
echo                      ######*+++++++++****##*+++++**#+++++++++++++             
echo                          ######*+++++++++++++++++++##*+++++++++++++           
echo                              #######*+++++++++++++*####*+++++++++++           
echo                                   ############      #####*++++++++++          
echo                                                       #####*++++++++          
echo                                                         #####*+++++           
echo                                                           #####                     
echo.

setlocal enabledelayedexpansion

set services=sysmain pcasvc dps diagtrack bam eventlog spooler
set all_running=true

for %%s in (%services%) do (
    sc query %%s | find "RUNNING" >nul
    if !errorlevel! == 0 (
	setlocal disabledelayedexpansion
        echo [[1;90m^![0m] Service [1;90m%%s[0m is running.
	setlocal enabledelayedexpansion
    ) else (
	setlocal disabledelayedexpansion
        echo [[1;91m![0m] Service [1;90m%%s[0m is not running.
	setlocal enabledelayedexpansion
        set all_running=false
        set /p start="Do you wish to start the service [1;93m%%s[0m? (y/n): "
        if /i "!start!"=="y" (
            sc start %%s
            timeout /t 1 >nul\
            sc query %%s | find "RUNNING" >nul
            if !errorlevel! == 0 (
		setlocal disabledelayedexpansion
                echo [[1;90m![0m] Service [1;90m%%s[0m is now running.
		setlocal enabledelayedexpansion
            ) else (
		setlocal disabledelayedexpansion
                echo [[1;90m!![0m] Service [1;90m%%s[0m failed to start.
		setlocal enabledelayedexpansion
            )
        ) else (
	    setlocal disabledelayedexpansion
            echo [[1;90m!![0m] Service [1;90m%%s[0m will not be started.
	    setlocal enabledelayedexpansion
        )
    )
)

if "!all_running!"=="true" (
    setlocal disabledelayedexpansion
    echo [[1;90m![0m] All processes are currently running.
    setlocal enabledelayedexpansion
echo.
) else (
    setlocal disabledelayedexpansion
    echo [[1;90m-[0m] Not all processes are running.
    setlocal enabledelayedexpansion
echo.
)

set /p join_discord="Would you like to join the Vision ScreenShare Discord? ([1;92my[0m/[1;31mn[0m): "
if /i "!join_discord!"=="y" (
    start https://dsc.gg/visionss
) else (
    echo.
    echo [0mPress any key to close the program.
    pause >nul
)

exit /b

