Write-Host "Execute this with the template in the current directory"
Write-Host "So, if validating the lansa template in .\azure-quickstart-templates\lansa-vmss-windows-autoscale-sql-database"
Write-Host "change to that directory and run this test as ..\test\validate-template.ps1"
Write-Host "Note that an error is displayed 'Import-Json : Invalid JSON primitive: .'. This may be ignored. Just pay attention to the final result"

Write-Host "Script Path = $($MyInvocation.MyCommand.Path)"
$script:IncludeDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host "Script Directory =  $($script:IncludeDir)"

try {
    $TemplatePath = Get-Location
    Write-Host "Template Directory = $($TemplatePath.Path)"

    # Run Best Practice Tests
    Import-Module $script:IncludeDir/arm-ttk/arm-ttk.psd1 -Verbose
    $TestResults = @(Test-AzTemplate -TemplatePath $TemplatePath.path)

    $TestResults

    if ($TestResults | ? {$_.Errors }) {
        # This code does not seem to be informative. May be useful in some circumstances. Developer to run it themselves as necessary.
        # When a need is found then maybe it becomes an option when running the script
        # $TestFailures =  $TestResults | Where-Object { -not $_.Passed }
        # $FailureTargetObjects = $TestFailures |
        #     Select-Object -ExpandProperty Errors |
        #     Select-Object -ExpandProperty TargetObject
        # $FailureTargetObjects
        Write-Host "Validation failed"
        exit 1
    }
} catch {
    $_
    Write-Host "Validation failed"
    exit 1
}

Write-Host "Validation succeeded"
exit 0
