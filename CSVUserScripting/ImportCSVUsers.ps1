#Import Users from CSV File
# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV C:NewUsers.csv

# Step through Each Item in the List

FOREACH ($Person in $UserList) {
	$Name = $Person.Name

	# Firstname from File
	$GivenName = $Person.Given

	# Pull Last name from file
	$Surname = $Person.Surname

	# Pull their username from CSV
	$Username=$Person.SAM

	# Create Principal from given emails
	$Principal=$Person.Principal

	# Password
	$Password=$Person.Password

	# Create User in Active Directory
	NEW-ADUSER –Name $Name –Surname $Surname –GivenName $GivenName –SamAccountName $Username –UserPrincipalName $Principal -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true
}

Write-Host "Would you like to remove the added users? (y/n)"
$Answer = Read-Host
if ( $Answer -eq 'y' -Or $Answer -eq 'Y' ) {
	FOREACH ($Person in $UserList) {
		$Name = $Person.Name

		# Firstname from File
		$GivenName = $Person.Given

		# Pull Last name from file
		$Surname = $Person.Surname

		# Pull their username from CSV
		$Username=$Person.SAM

		# Create Principal from given emails
		$Principal=$Person.Principal

		# Password
		$Password=$Person.Password
	
		Remove-ADUSER $Username
	}
}

echo Done