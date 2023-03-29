@echo OFF
echo -
echo   Installation start . . .
echo -
echo   # Leave blank to use the default path.
echo   # Default patch: C:\Program Files\
echo -
:ip
set /p mainPatch=". Enter installation path: "
echo -
if "%mainPatch%" == "" (
  echo   Installing with the default path . . .
  C:
  cd C:\Program Files\
  md Pusher_v1
  cd Pusher_v1
) else (
  if exist "%mainPatch%" (
    echo   Installation path: %mainPatch%
    echo   Installation...
    %mainPatch:~0,1%:
    cd %mainPatch%
    md Pusher_v1
    cd Pusher_v1
  ) else (
    echo   ERROR. The installation path is incorrect,
    echo   Please try again
    echo -
    goto ip
  )
)
echo -
@copy %~dp0data01 push.bat
@echo empty>data
@echo #config>conf
echo -
echo   # Please enter project path.
echo   # You can change this at any time.
echo   # In the future, use a command "push /conf"
echo   # to edit the settings
echo -
:inp3
set /p pp=". Enter project path: "
if exist "%pp%" (
  goto ok2
) else (
  echo   ERROR. Path is incorrect.
  goto inp3
)
:ok2
@echo default=%pp%>>conf
echo -
setx /M PATH "%PATH%;%cd%;
path %PATH%;%cd%;
echo -
echo   # The installer can create/clone a git repository
echo   # and connect it to your remote github
echo   # repository via ssh connection.
echo -
echo   # WARNING. This will remove all your existing ssh keys
echo -
:inp
set /p q=". Create a git repository and start configuring ssh? <y/n> : "
if "%q%" == "" goto inp
if "%q%" == "n" (
  echo -
  echo   INSTALLATION COMLITED
  echo -
  PAUSE
  exit
)
if "%q%" == "y" (
  echo -
  echo   Starting . . .
  goto git
) else (
  goto inp
)
:git
echo -
echo   # Choose an action.
echo     1. Create a new git repository
echo     2. Clone existing
:inp2
set /p q2=". Choose... <1/2> : "
if "%q2%" == "" goto inp2
if "%q2%" == "1" (
  echo -
  goto ng
)
if "%q2%" == "2" (
  echo -
  goto cg
) else (
  goto inp2
)
:ng
echo Creating a new git repository .  . .
%pp:~0,1%:
cd %pp%
echo "# test-ssh" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
echo -
echo   Create SSH Key . . .
echo   # Notepad will open, copy
echo   # the key from there and add it to
echo   # your github in the settings.
echo - 
set /p email=". Enter the email associated with your github: "
ssh-keygen -t rsa -b 4096 -C "%email%"
notepad C:\Users\%UserName%\.ssh\id_rsa.pub
echo -
set /p gitUrl="Enter ssh url to your github rep: "
git remote add origin %gitUrl%
git push --all
PAUSE
exit
:cg
echo Clone existing.
PAUSE
exit





