Write-Host "Execute this with the template in the current directory"
Write-Host "So, if validating the lansa template in .\azure-quickstart-templates\lansa-vmss-windows-autoscale-sql-database"
Write-Host "change to that directory and run this test as ..\test\validate-template.ps1"
Write-Host "Note that an error is displayed 'Import-Json : Invalid JSON primitive: .'. This may be ignored. Just pay attention to the final result"

$MyInvocation.MyCommand.Path
$script:IncludeDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$TemplatePath = Get-Location
# Run Best Practice Tests
Import-Module $script:IncludeDir/test-ttk/arm-ttk/arm-ttk.psd1 -Verbose
$testOutput = @(Test-AzTemplate -TemplatePath $TemplatePath)

$testOutput

if ($testOutput | ? {$_.Errors }) {
    Write-Host "Validation failed"
    exit 1
} else {
    Write-Host "Validation succeeded"
   exit 0
}