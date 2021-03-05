Write-Host "If your name in input below, you're locked out."
$names = "jcash", "vgogh", "jsmith"

$count = 0

ForEach ($singleName in $names) {
$count++
Disable-ADAccount $singleName

Write-Host "$count"
Write-Host "$singleName is disabled"
}

echo "$count users were locked out." 
$Answer = Read-Host -Prompt "Would you like to enable them? (y/n)"

if ( $Answer -eq 'y' ) {
ForEach ($singleName in $names) {

Enable-ADAccount $singleName

Write-Host "$count"
Write-Host "$singleName is enabled"
$count--
}
echo "All accounts have been reenabeled."
}
else {
Write-Host Okay! Sucks for them. Bye!
}