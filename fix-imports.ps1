# Script to fix environment import paths and remove duplicates

# Define correct import paths based on directory depth
$pathMappings = @{
    "src\app\services" = "../../environments/environment"
    "src\app\components" = "../../../environments/environment"
    "src\app\pages" = "../../../environments/environment"
    "src\app\userprofile" = "../../environments/environment"
}

# Get all files that were modified
$filesToFix = Get-ChildItem -Path "src\app" -Filter "*.ts" -Recurse | Where-Object { 
    (Get-Content $_.FullName -Raw) -match "environment.*from.*environments" 
}

foreach ($file in $filesToFix) {
    Write-Host "Fixing: $($file.FullName)"
    
    $content = Get-Content $file.FullName -Raw
    
    # Remove duplicate environment imports
    $content = $content -replace "import \{ environment \} from.*environments.*';\r?\n", ""
    
    # Determine correct path based on file location
    $relativePath = $file.DirectoryName.Replace((Get-Location).Path + "\", "").Replace("\", "/")
    $correctPath = "../../environments/environment"
    
    if ($relativePath -like "*components*") {
        $correctPath = "../../../environments/environment"
    } elseif ($relativePath -like "*pages*") {
        $correctPath = "../../../environments/environment"
    }
    
    # Add single correct environment import after the last import
    if ($content -match "import.*from.*';") {
        $content = $content -replace "(import.*from.*';?\r?\n)(?!import)", "`$1import { environment } from '$correctPath';`r`n"
    }
    
    Set-Content $file.FullName -Value $content -NoNewline
}

Write-Host "Fixed import paths for all files!"