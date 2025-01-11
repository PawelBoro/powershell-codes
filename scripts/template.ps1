#? 3 - Using the help system
Get-Command -Verb '' -Noun ''
help *text* -Parameter
#? 5 - Working with Providers
Get-ChildItem
Get-Item
New-Item -Path $path -Name $name -ItemType File/Directory #mkdir
Set-Item -Path path -Value number
Set-Location -Path path
Set-ItemProperty -Path path -PSProperty/Name smth -Value 0
#? 6 - The pipeline: Connecting commands
Compare-Object -ReferenceObject (Import-Clixml ./test.xml) -DifferenceObject Get-Process -Property Name
Export-Csv -IncludeTypeInformation
Get-Command
Get-Command | Export-Csv services.CSV -Confirm
Get-Content ./test.json | ConvertFrom-Json
Get-Process
Get-Process | Export-Csv
Get-Process | ConvertTo-Json | Out-File procs.json
Import-Csv name.csv
#? 7 - Adding commands
#Module
Get-Module -Name Name
Find-Module -Name name
Install-Module -Name name
Update-Module -Name name
Remove-Module
#Rest
Get-PSProvider
(Get-Content Env:/PSModulePath) -split ':' lub $env:PSModulePath -split ':'
# Dodanie ścieżki do zmiennej ścieżki do modułów
$env:PSModulePath += [System.IO.Path]::PathSeparator + 'C:\Scripts/myModules'
Import-Module GoogleCloud -Force # Google Cloud Module need to be downloaded first to be found
# Add your own prefix to any module when you import the module.
Import-Module ModuleName -Prefix MyPrefix will change Get-Original
CmdLet to Get-MyPrefixOriginalCommand.
# Find a commands from specific module
Get-Command -Module Network
#? Objects
Get-Member
Get-Process | Sort-Object CPU, ID -desc
Select-Object
Get-Process | Select-Object -Property Name, ID
Get-Process | Sort-Object CPU -Descending | Get-Member
#? 11
Get-Process | Format-Table -Property Id
Get-Process | Format-List -Property Id
Get-Process | Format-Wide name -col 4
Get-Process | Format-Table Id, Name, @{l = 'VirtualMB'; e = { $_.vm / 1MB } }, @{ Label = 'PhisicalMB'; e = { $_.WorkingSet / 1MB } }
Get-Module | Format-Table @{l = 'ModelName'; e = { $_.Name } }, @{l = 'ModelVersion'; e = { $_.Version } }
Get-Alias gci
Get-ChildItem ~ -Directory | Format-Wide -Column 4
#? 12
