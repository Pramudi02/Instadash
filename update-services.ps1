# PowerShell script to update all service files to use environment configuration

$serviceFiles = @(
    "src\app\services\admin-analytics.service.ts",
    "src\app\services\audit-log.service.ts", 
    "src\app\services\audit.service.ts",
    "src\app\services\auth.service.ts",
    "src\app\services\automation.service.ts",
    "src\app\services\businessdash.service.ts",
    "src\app\services\campaign.service.ts",
    "src\app\services\expense.service.ts",
    "src\app\services\finance.service.ts",
    "src\app\services\inventory.service.ts",
    "src\app\services\marketing-dashboard.service.ts",
    "src\app\services\orders.service.ts",
    "src\app\services\ordersummary.service.ts",
    "src\app\services\password-reset.service.ts",
    "src\app\services\sales-access.service.ts",
    "src\app\services\system-configuration.service.ts",
    "src\app\services\userProfile.service.ts"
)

foreach ($file in $serviceFiles) {
    if (Test-Path $file) {
        Write-Host "Updating $file"
        
        # Read the file content
        $content = Get-Content $file -Raw
        
        # Add environment import if not present
        if ($content -notmatch "import.*environment.*from.*environments") {
            $content = $content -replace "(import.*from.*angular/core.*;\r?\n)", "`$1import { environment } from '../../environments/environment';`r`n"
        }
        
        # Replace localhost URLs with environment.apiUrl
        $content = $content -replace "http://localhost:5241", "`${environment.apiUrl}"
        
        # Write the updated content back
        Set-Content $file -Value $content -NoNewline
    }
}

Write-Host "Service files updated successfully!"