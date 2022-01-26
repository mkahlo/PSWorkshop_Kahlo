# Override GPO
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell -Name EnableScripts -Value 1
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell -Name ExecutionPOlicy -Value RemoteSigned

# Restore GPO
gpupdate /force

# GITHUB
https://github.com/FriedrichWeinmann/POSH_Workshop_2022-01-24_FS

# Was ist PowerShell?
    # -> Automatisierungs Engine 

# TOOLS
# neue PWSH PowerShell Core Version 7.2.1
https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?WT.mc_id=THOMASMAURER-blog-thmaure&view=powershell-7
# -> Download 
# Visual Code 
# Shift+Alt+F -> rückt den Code sauber ein
# Powershell Extension hinzufügen

# History (EingabeHistory)
Get-History | Out-GridView -PassThru | Invoke-History
Get-Content (Get-PSReadLineOption).HistorySavePath | Out-GridView -PassThru
Get-Content "C:\Users\akm8fe\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" | Out-GridView -PassThru

# Module PSUtil -> F7 Taste zeigt Out-GridView an 
# Ein Tool von Freidrich Weimann , selbst gebaut
Install-Module PSUtil

#HELP
Get-Help Get-ChildItem -Examples
Get-Help Get-Mailbox -Examples
Get-Help Get-Mailbox -ShowWindow

Install-Module ExchangeOnlineManagement
Show-Command Get-Mailbox


#Variable
${ } = "Hallo"

function Write-Hello {
    "Hello $env:Username"   
}
write-hello

function Write-Hello {
    [CmdletBinding()]
    param (
        $Surename = $env:COMPUTERNAME,
        $Givenname
    )"Hello $ParameterName, $Givenname" 
    Write-Host "Mich sieht man"
    Write-Verbose "Bonus-Nachricht: $surename, $Givenname "  
}
write-hello -surename "akm8feee" -Givenname "Markus" -Verbose
write-hello -Givenname "Markus" -Verbose

$VerbosePreference = 'Continue'
$VerbosePreference = 'si'

get-command $VerbosePreference


function Get-NetCommand {
    Get-Command -module NetTCPIP | Sort-Object Name
}

# Funktion ersetzt Get-Command -module NetTCPIP -Name GET-*
function Get-NetCommand {  
    param (
    $ParameterModulName = "NetTCPIP",   
    $ParameterName = ""
    )
    Write-Verbose "Übergebene Parameter $ParameterModulName, $($ParameterName)"
    Get-Command -Module $ParameterModulName -Name $ParameterName
    #Get-Command -module NetTCPIP | Sort-Object Name
   # Get-Command -module NetTCPIP $ParameterName
}

Set-Alias -Name GetNetC -Value Get-NetCommand
Get-NetCommand
Get-NetCommand -ParameterName Get-* -verbose

#Get-Command -module NetTCPIP Get-*
#Get-NetTCPConnection
#Get-Command Get-*

$file | Get-Member 

# Variablen und deren Typen
32 -is [System.String]
[int],[string],[double],[bool] | ForEach-Object {32 -is $_.FullName}


# Variable Global oder Local (nur in Funktion/Sandbox verfügbar)
# Scope

$global:Zahlwert = 42
function Get-Zahl {
    param ( [int]$localZahlwert   )
    Write-Host "Zahl: $localZahlwert"
    Write-Host "Zahl: $zahlwert" # hier wird die globale Variable angezeigt, die Außerhalb der Funktion angelegt wurde
    Write-Host "Zahl global: $global:Zahlwert"
    $zahlwert = 001
    Write-Host "Zahl danach: $zahlwert" # hier wird die locale Variabel angezeigt, lokale=in der Funktion, diese wird nach der Funktion nicht mehr dargestellt
}
Get-Zahl
$zahlwert


# Bessere Lösung für $tempname + "_" + ,$env:USERNAME
$tempname = "akm8fe"
$tempname = $tempname,$env:USERNAME -join "_"