$count = 0
$number = Read-Host -Prompt "What do you want to count down from?"
Do {
echo $number
$number = $number - 1

} while($number -gt 0)
echo "BLAST OFFFF!!!"