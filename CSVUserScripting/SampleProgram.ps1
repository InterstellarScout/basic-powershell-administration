#Import Users from CSV File
# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV C:NewUsers.csv

# Step through Each Item in the List

FOREACH ($Person in $UserList) {

# Build Username from First name and Last Initial
$Username=$Person.Firstname+$Person.Lastname.substring(0,1)

# Put our Domain name into a Placeholder, who wants all that typing?
$Domain=’@blueville.local’

# Build the User Principal Name Username with Domain added to it
$UPN=$Username+$Domain

# Create the Displayname
$Name=$Person.Firstname+” “+$Person.Lastname

# Create User in Active Directory
NEW-QADUSER –FirstName $Person.Firstname –Lastname $Person.Lastname –Name $DisplayName $Name –SamAccountName $Username –UserPassword ‘1NewPassword’ –UserPrincipalName $UPN –Name $Name –ParentContainer ‘Blueville.local/Division/Contoso’

}