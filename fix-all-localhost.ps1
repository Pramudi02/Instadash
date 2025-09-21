# Comprehensive script to update all localhost URLs to use environment configuration

# Get all TypeScript files that contain localhost:5241
$filesToUpdate = Get-ChildItem -Path "src\app" -Filter "*.ts" -Recurse | Select-String -Pattern "localhost:5241" | Select-Object -ExpandProperty Path | Sort-Object -Unique

Write-Host "Found $($filesToUpdate.Count) files to update"

foreach ($file in $filesToUpdate) {
    Write-Host "Updating: $file"
    
    # Read file content
    $content = Get-Content $file -Raw
    
    # Add environment import if not present
    if ($content -notmatch "import.*environment.*from.*environments") {
        # Find the last import statement and add environment import after it
        $content = $content -replace "(import.*from.*';?\r?\n)(?!import)", "`$1import { environment } from '../../environments/environment';`r`n"
    }
    
    # Replace all localhost:5241 URLs with environment.apiUrl
    $content = $content -replace "http://localhost:5241", "`${environment.apiUrl}"
    
    # Handle cases where the URL is just the API part
    $content = $content -replace "`\`${environment.apiUrl}/api", "`${environment.apiUrl}/api"
    $content = $content -replace "`\`${environment.apiUrl}/Customer", "`${environment.apiUrl}/Customer"
    $content = $content -replace "`\`${environment.apiUrl}/table", "`${environment.apiUrl}/table"
    $content = $content -replace "`\`${environment.apiUrl}/Table", "`${environment.apiUrl}/Table"
    $content = $content -replace "`\`${environment.apiUrl}/chathub", "`${environment.apiUrl}/chathub"
    
    # Write back to file
    Set-Content $file -Value $content -NoNewline
}

Write-Host "All files updated successfully!"
Write-Host "Files updated: $($filesToUpdate.Count)"