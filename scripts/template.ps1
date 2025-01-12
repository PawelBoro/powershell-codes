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
#? 12 Filtering and comparisons
help about_Comparison_Operators
Get-Process | Where-Object -FilterScript { $_.WorkingSet -gt 100MB }
Get-Process | Where-Object { $_.WorkingSet -gt 100MB }
Get-Process | Where-Object { $_.Name -ne 'pwsh' -and $_.ProcessName -ne 'sh' }
Get-Process | Where-Object { $_.ProcessName -ne 'pwsh' } | Sort-Object -Property VM -Descending | Select-Object -First 10 | Measure-Object -Property VM -Sum
Get-Command -Module PSReadLine | Where-Object { $_.Name -like 'get*' }
Get-Command Get-* -Module PSReadLine
Get-ChildItem /usr/bin | Where-Object { $_.Size -gt 5MB }
Get-Module | Where-Object { $_.Size -gt 5MB -and $_. }
Find-Module -Name PS* | Where-Object { $_.Author -like 'Microsoft' }
Find-Module -Name PS* | Format-Table Version, Author, Name -AutoSize | Select-Object -First 10
#? 13 Remote control: Onet-to-one and many-to-many
SSH
#? 14 Multitasking with Background Jobs
Start-Job -ScriptBlock { Get-ChildItem }
Start-ThreadJob -ScriptBlock { Get-ChildItem }
Get-Command New-Item -Syntax
Get-Job -Name Job1 | Format-List *
Get-Job -Name Job1 | Format-Table *
Receive-Job -Id 1 #Results will be lost
Receive-Job -Id 1 -Keep #Results will stay
Remove-Job — This deletes a job, and any output still cached with it, from memory.
Stop-Job — If a job seems to be stuck, this command terminates it. You can still receive whatever results were generated to that point.
Wait-Job - This is useful if a script is going to start a job or jobs and you want the script to continue only when
the job is done. This command forces the shell to stop and wait until the job (or jobs) is completed, and then allows the shell to continue
Remove-Job -Id 1
Start-ThreadJob -ScriptBlock { Get-ChildItem / -Recurse -Filter '*.txt' }
#? 15 Working with many objects, one at a time
#Parallel function for ForEach-Object
Get-Content -Path vaultsToCreate.txt |
ForEach-Object -Parallel {
    New-AzKeyVault -ResourceGroupName manning -Location 'UK South' -Name $_
}
#
Measure-Command {
    Get-Content -Path vaultsToCreate.txt |
    ForEach-Object -ThrottleLimit 10 -Parallel {
        Write-Output $_
        Start-Sleep 1
    }
}
Get-Process | Get-Member -MemberType Method
Get-Content computers.txt | ForEach-Object { $_.ToUpper() }
# Get-ChildItem *deleteme* | Remove-Item -Recurse -Force
# Remove-Item *deleteme* -Recurse -Force
# Get-ChildItem *deleteme* | ForEach-Object { $_.Delete() }
