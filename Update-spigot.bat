:: Update your spigot jar file
:: Made by WernerWaage

:: Config - Change these values as needed
:: Version is the revision you are downloading
:: targetname is the name of the file after all processing has been done, i call spigot.jar from my batch files when i start my server
:: Buildtoolslocation is the location of the BuildTools.jar file. I put mine in the same folder as my minecraft server
:: Target location, the output location from the git buildtools
:: Gitbash, location of the git bash executable 
SET VERSION="1.13"
SET TARGETNAME="spigot.jar"
SET BUILDTOOLSLOCATION="C:\Users\Simon\AppData\Local\McMyAdmin\Minecraft"
SET TARGETLOCATION="C:\Users\Simon\AppData\Local\McMyAdmin\Minecraft"
SET GITBASHLOCATION="C:\Program Files\Git\git-bash.exe"
SET STARTSERVER="C:\Users\Simon\AppData\Local\McMyAdmin\Minecraft\start-server-spigot.bat"



:: Prepare to launch
SETLOCAL enableextensions enabledelayedexpansion
@echo OFF
CLS

:: Starting countdown for automatic start of server.
for /l %%N in (15 -1 1) do (
  set /a "sec=%%N%%60, n-=1"
  if !sec! lss 10 set sec=0!sec!
  cls
  choice /c:CN1 /n /m "Starting server in !sec! - Press S or wait to start server, or M to show the update menu. " /t:1 /d:1
  if not errorlevel 3 goto :break
)
cls
echo Starting server in 00 - Press S or wait to start server, or M to show the update menu. 
:break



for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A


:promptuser1
echo (U)pdate, (S)tart server or (E)xit?
set INPUT=
set /P INPUT2=Type input: %=%
If /I "%INPUT2%"=="u" goto update
If /I "%INPUT2%"=="s" goto startserver 
If /I "%INPUT2%"=="e" goto done


:: Start update
:update
ECHO -----------------------------------------------------------------------
ECHO Starting Spigot Update
START /wait "gitbashww" "C:\Program Files\Git\git-bash.exe" --cd="%BUILDTOOLSLOCATION%" -c "java -jar BuildTools.jar --rev %VERSION%"
ECHO Let the git bash process run a few minutes, when ready press a key to rename old and new files.
ECHO -----------------------------------------------------------------------
PAUSE

:: Replace old files with new ones
ECHO Deleting %TARGETNAME%.old
CD /d "%TARGETLOCATION%"
DEL "%TARGETNAME%.old"
ECHO Renaming %TARGETNAME% to %TARGETNAME%.old
REN "%TARGETNAME%" "%TARGETNAME%.old"
ECHO Renaming spigot-%VERSION%.jar to spigot.jar (End product)
REN "spigot-%VERSION%.jar" "%TARGETNAME%"
ECHO Done!
ECHO.
ECHO -----------------------------------------------------------------------
:: PAUSE

:: Optionally start the server
:promptuser2
echo Would you like to start the server again?(Y/N)
set INPUT=
set /P INPUT=Type input: %=%
If /I "%INPUT%"=="y" goto startserver 
If /I "%INPUT%"=="n" goto done

:startserver
ECHO Starting server script, good luck and have a nice day! -WernerWaage 
CALL "%STARTSERVER%"

:done
ECHO Upgrades complete!
ECHO Dont forget to start the server manually!
ECHO Bye!
EXIT 0


:::              _ _,---._
:::           ,-','       `-.___
:::          /-;'               `._
:::         /\/          ._   _,'o \
:::        ( /\       _,--'\,','"`. )
:::         |\      ,'o     \'    //\
:::         |      \        /   ,--'""`-.
:::         :       \_    _/ ,-'         `-._
:::          \        `--'  /                )
:::           `.  \`._    ,'     ________,','
:::             .--`     ,'  ,--` __\___,;'
:::              \`.,-- ,' ,`_)--'  /`.,'
:::               \( ;  | | )      (`-/
:::                 `--'| |)       |-/
:::                   | | |        | |
:::                   | | |,.,-.   | |_
:::                   | `./ /   )---`  )
:::                  _|  /    ,',   ,-'
:::                 ,'|_(    /-<._,' |--,
:::                 |    `--'---.     \/ \
:::                 |          / \    /\  \
:::               ,-^---._     |  \  /  \  \
:::            ,-'        \----'   \/    \--`.
