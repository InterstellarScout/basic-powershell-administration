REM This Script is used to change the password of an existing user, or create one if none exists.
REM The use case is if you have different users across a company or companies, and want to update them in one script.
REM Works only on Windows 10

REM First the Variables
REM Desired Username:
SET newUserName=user
SET newPassword=newPassword

REM First off, lets clean up. If the user mdg exists, delete it. All local admins will be the user you want above. 
REM Assume the user is found unless not
SET userFound=1 
REM Delete mdg... REM If the user is found...
net user | find /i "user" || SET userFound=0
IF %userFound%==1 ( ECHO "found... Deleting." && net user "user" /delete )

SET userFound=1 
REM Delete MDG... REM If the user is found...
net user | find /i "USER" || SET userFound=0
IF %userFound%==1 ( ECHO "found... Deleting." && net user "USER" /delete )

SET userFound=1 
REM Delete MDG... REM If the user is found...
net user | find /i "USER1" || SET userFound=0
IF %userFound%==1 ( ECHO "found... Deleting." && net user "USER1" /delete )

SET userFound=1 
REM Delete MDG... REM If the user is found...
net user | find /i "USER2" || SET userFound=0
IF %userFound%==1 ( ECHO "found... Deleting." && net user "USER2" /delete )

REM Delete MDGAdmin... REM If the user is found...
SET userFound=1 
net user | find /i "AdminUser" || SET userFound=0
IF %userFound%==1 ( ECHO "found... Deleting." && net user "AdminUser" /delete )

REM Create the new user with the new password if it isn't found already.
SET userFound=1 

REM Attempt to find the current local admin. If found, the second command will NOT occur.
net user | find /i %newUserName% || SET userFound=0 

REM Change password... If the user is found...
IF %userFound%==1 ( ECHO "found" ) else ( ECHO "not found... Creating." )
REM Change existing user password else create the user.
IF %userFound%==1 ( net user %newUserName% %newPassword% ) else ( net user %newUserName% %newPassword% /add && net localgroup administrators %newUserName% /add )

SET newUserName=Nice Try. 
SET newPassword=Nice Try.
echo Done.