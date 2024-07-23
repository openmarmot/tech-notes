# create a csv with a list of files in a directory and their size in MB
Get-ChildItem -Recurse | Select-Object FullName, @{Name="Size(MB)";Expression={[math]::Round($_.Length / 1MB, 2)}} | Export-Csv -Path file_list.csv -NoTypeInformation
