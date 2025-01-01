
Get-PSDrive -PSProvider FileSystem | select Name, Root, 
@{n="Used in GB";e={[math]::Round($_.Used/1GB,2)}}, 
@{n="Free in GB";e={[math]::Round($_.Free/1GB,2)}}, 
@{n="Percent Free";e={([math]::Round($_.Free/($_.Used+$_.Free),2))*100}},
@{n="ola mundo";e={1+1};n="teste"}


Param(
[Parameter(Mandatory=$True)]
[string]$FolderName,
[Parameter(Mandatory=$True)]
[string]$FileName
)

New-Item $FolderName -type directory
New-Item $FileName -type file




 Get-ChildItem -Path C:\Users\RenanCarvalhoDosSant\Desktop -Filter ‘te*’


 Write-Host (([math]::Round(10/(30+40),2))*100)%




 Get-WmiObject -Class Win32_LogicalDisk |
Select-Object -Property DeviceID, VolumeName, @{Label='FreeSpace (Gb)'; expression={($_.FreeSpace/1GB).ToString('F2')}},
@{Label='Total (Gb)'; expression={($_.Size/1GB).ToString('F2')}},
@{label='FreePercent'; expression={[Math]::Round(($_.freespace / $_.size) * 100, 2)}}|ft

















