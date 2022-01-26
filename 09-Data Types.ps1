# Objects & Classes
## Overview
## Accessing Properties & Methods
### How?
### FL *
### Get-Member
## The PSObject

# Types
## Testing for type
## Static Members
## Common Types
<#
[int] # Whole number (1,2,3,4,-1,..)
[string] # Text
[long] # Whole number, larger than int
[bool] # Truth ($true / $false)
[double] # Arbitrary, potentially non-whole (1.2)
[byte] # Single Byte
[char] # Single character
#>
## Type Operators
### Soft Typing
### Hard Typing

## Functions & Parameter Types


$now = Get-date
$now
$now.Month
$now.AddDays(-10)

$mensch = New-Object Mensch 
$mensch

class Mensch {
    [string]
}

###########################################

$file = Get-Item "U:\_fromAFU\Commands\PS-Workshop\RepositoryGitHub\file3.txt" 
$file | FL *name*
$file.BaseName

$file.LastWriteTime
$file.LastWriteTime = (Get-Date).AddYears(-50)
$file.CreationTime = (Get-Date).AddYears(-51)
$file.PSObject.Properties | Where-Object Name -like Last*


$MBXdata = Get-Mailbox akm8fe
$MBXdata | FL
$MBXdata.EmailAddresses

$MBXdata | Get-Member
$MBXdata.PSObject.Properties | Where-Object Name -Like Display*

$zahl = "3"
$zahl.GetType().FullName #STRING
$zahl = 3
$zahl.GetType().FullName #INT
[int]$zahl = "34" # HARD-Typing  ,damit ändert sich derParameter Type nicht mehr
$zahl -is [int]
[int] | fl *
[int]::MaxValue
[double]::MaxValue
[System.Boolean]::FalseString
[char]::MaxValue

$zahl
<# Task 1
Now that we know how to define the expected type for a parameter,
we really should go back and update our previous commands (5-7) so that
their parameters have an appropriate expected type.
#>

<# Task 2
For debugging purposes, we want a quick helper command that takes an
input object and returns all its properties and their values.

It should support filtering by property-name.

Notes:
- Do not use Format-List / FL for this command
#>

[long].FullName


function FunctionName {
    param (

        [Parameter(Mandatory = $true)]
        
        
        [ValidateRange(1,365)]
        [int]
        $selecteddate
    )
    Write-Verbose "Datum wird angezeigt + $($selecteddate) Tage"
    (Get-date).AddDays($selecteddate)
}

FunctionName  -verbose
FunctionName 4 -verbose # hier muss ein Int (Zahl) mit angegbene werden
FunctionName 444 -verbose 
#########################################################################


$items = Get-ChildItem -Path "U:\_fromAFU\Commands\PS-Workshop\RepositoryGitHub" 

foreach ($item in $items[0]) {
    $item.PSObject.Properties | Select-Object Name,Value
}

(Get-Date).AddDays(1)


function Get-MailboxDetails {
    <#
    .PARAMETER MailboxName
    Enter MailboxName as Name,Alias or PrimarySMTP or UserPrincipalName

    
    .EXAMPLE
    Get-MailboxDetails akm8fe -MailboxProperty RetentionPolicy 
    #>
    
    param (
        [string]$MailboxName,
        [ValidateSet('Name','RetentionPolicy')]
        [string]$MailboxProperty
    )
    Write-Verbose "Das Property $($MailboxProperty) wird angezeigt"

    Get-Mailbox $MailboxName | Select-Object -ExpandProperty $MailboxProperty
}

Get-Help Get-MailboxDetails -Examples
Get-MailboxDetails akm8fe -verbose
Get-MailboxDetails akm8fe -MailboxProperty RetentionPolicy -verbose

Get-Mailbox akm8fe | Select-Object RetentionPolicy 
Get-Mailbox akm8fe | Select-Object -ExpandProperty RetentionPolicy 

Get-Mailbox akm8fe| Get-Member


# Insich geschloßene Funktion = SandBox
$zahlwert = 42
function Get-Zahl {
    param ( [int]$Zahlwert   )
    Write-Host "Zahl: $zahlwert" # hier wird die globale Variable angezeigt, die Außerhalb der Funktion angelegt wurde
    $zahlwert = 001
    Write-Host "Zahl danach: $zahlwert" # hier wird die locale Variabel angezeigt, lokale=in der Funktion, diese wird nach der Funktion nicht mehr dargestellt
}
Get-Zahl  # hier wird keine Zahl in die Funktion übergeben | somit $zahlwert oin Funktion von Global
Get-Zahl -Zahlwert $zahlwert # hier wird zahjlwert (global) übergeben, und in Funktion ist diese direkt als lokal enthalten
$zahlwert

# Siehe Debug Modus : 