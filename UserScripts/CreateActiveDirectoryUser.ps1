Write-Host 'This script it used to create Active Directory User.'

$Answer = Read-Host -Prompt 'Would you like to continue? (y/n)'
echo $Answer
echo " "

Do {

if ($Answer -eq 'y' -Or $Answer -eq 'Y') {
    Write-Host "Perfect! Let's make the new user!" 
    Do {
        Do {
            Write-Host "Enter the user's full name:"
            $name = Read-Host
            echo $name "Is this correct? (y/n)"
            $Answer2 = Read-Host
        } While ( $Answer2 -ne 'Y' -Or $Answer2 -ne 'y' )

        echo " "

        Do {
            Write-Host "Enter the user's first name:"
            $Givenname = Read-Host
            echo $Givenname "Is this correct? (y/n)"
            $Answer2 = Read-Host
        } While ( $Answer2 -ne 'Y' -Or $Answer2 -ne 'y' )

        echo " "

        Do {
            Write-Host "Enter the user's last name:"
            $Surname = Read-Host
            echo $Surname "Is this correct? (y/n)"
            $Answer2 = Read-Host
        } While ( $Answer2 -ne 'Y' -Or $Answer2 -ne 'y' )

        echo " "

        Do {
            Write-Host "Enter the user's User Principal Name (email address):"
            $UserPrincipalName = Read-Host
            echo $UserPrincipalName "Is this correct? (y/n)"
            $Answer2 = Read-Host
        } While ( $Answer2 -ne 'Y' -Or $Answer2 -ne 'y' ) 

        echo " "

        Do {
            Write-Host "Enter the user's Sam Account Name (username):"
            $SamAccountName = Read-Host
            echo $SamAccountName "Is this correct? (y/n)"
            $Answer2 = Read-Host
        } While ( $Answer2 -ne 'Y' -Or $Answer2 -ne 'y' ) 

        #Now is where all that information is put together. If there are any problems, the script will need to be redone.
        New-ADUser -Name $name -GivenName $Givenname -Surname $Surname -UserPrincipalName $UserPrincipalName -SamAccountName $SamAccountName

        Get-ADUser $SamAccountName
        echo "Is all information correct? (y/n)"
        $continue = Read-Host

        if ( $continue -ne 'Y' -Or $continue -ne 'y' ) {
            Remove-ADUser $SamAccountName 
        }
    } While ( $continue -ne 'Y' -Or $continue -ne 'y') 

    echo " "

    Do {
        Do {
            Write-Host "Now please enter this user's password:"
            $password = Read-Host -AsSecureString
        
            Write-Host "Please reenter the password:"
            $password2 = Read-Host -AsSecureString
        } While ($password -eq $password2)

        #Applying the new user password. If it is accepted, it will move on, otherwise the user will have the chance to reset it.
        Set-ADAccountPassword $SamAccountName -NewPassword $password

        echo $password "Is this correct? (y/n)"
        $Answer2 = Read-Host
    } While ( $Answer2 -ne 'Y' -Or $Answer2 -ne 'y' )

    echo " "
    
    Write-Host "Would you like to require the user to change their password upon next login? (y/n)"
        $ChangePassword = Read-Host
    if ( $ChangePassword -eq 'y' -Or $ChangePassword -eq 'Y') {
        Set-ADUser -Identity $SamAccountName -ChangePasswordAtLogon $TRUE
    }
    else {
        Set-ADUser -Identity $SamAccountName -ChangePasswordAtLogon $FALSE
    }

    echo " "

    Write-Host "Would you like to enable the account right away? (y/n)"
        $Enable = Read-Host
    if ( $Enable -eq 'y' -Or $Enable -eq 'Y') {
        Enable-ADAccount $SamAccountName
    }
    
    echo " "
    echo "Congrats! You hame created user $SamAccountName"
    Get-ADUser $SamAccountName
    
    echo "Would you like to create another user? (y/n)"
    $Answer = Read-Host
} #If answer is yes
echo " "

} While( $Answer -eq 'y' -Or  $Answer -eq 'Y')

echo "Okay, bye." 
