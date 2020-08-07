Write-Host "Script may be executed with any current directory. It will still place the TTK in the correct location."

$MyInvocation.MyCommand.Path
$script:IncludeDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define Variables
$ttk_folder = $script:IncludeDir
$ttk_asset_path = "$env:temp\AzTemplateToolKit.zip"

# Download TTK
New-Item -Path $ttk_folder -ItemType Directory -verbose -force
Invoke-WebRequest -Uri "https://github.com/Azure/azure-quickstart-templates/releases/download/marketplace/AzTemplateToolKit.zip" -OutFile $ttk_asset_path -verbose

# Expand the TTK files
Write-Host "Expanding files..."
Expand-Archive -Path  $ttk_asset_path -DestinationPath $ttk_folder -force
Write-Host "Expanded files found:"
Get-ChildItem $ttk_folder -Recurse
