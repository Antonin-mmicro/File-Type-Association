$path = "$env:TEMP\ViveTool\"
$function1 = "43229420"
$function2 = "27623730"

[int]$exit_code = "0"

if (Test-Path $path) {
	
} else {
    Write-Host "ViveTool n'est pas installé, Installation en cours..."
    $repo = "thebookisclosed/ViVe"
    $apiUrl = "https://api.github.com/repos/$repo/releases/latest"

    Write-Host "Récupération de la dernière version de ViveTool..."

    $release = Invoke-RestMethod -Uri $apiUrl -Headers @{
        "User-Agent" = "PowerShell"
    }

    $asset = $release.assets | Where-Object {
        $_.name -match "ViveTool.*\.zip"
    } | Select-Object -First 1

    if (-not $asset) {
        Write-Error "Impossible de trouver l'archive ViveTool."
        exit 1
    }

    $zipPath = "$env:TEMP\$($asset.name)"

    Write-Host "Téléchargement de $($asset.name)..."
    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $zipPath

    Write-Host "Extraction de ViveTool..."
    Expand-Archive -Path $zipPath -DestinationPath $path -Force

    Write-Host "ViveTool installé dans : $path"
}
Push-Location $path
$viveQuery = .\ViveTool.exe /query
function Is-UserEnabled($featureID) {
    $result = .\ViveTool.exe /query $featureID

    return (
        $result -match "State\s*:\s*Enabled \(2\)" -and
        $result -match "Priority\s*:\s*User"
    )
}



# Vérification pour 43229420

if (Is-UserEnabled $function1) {
    Write-Host "La fonctionnalité 43229420 est activée"
    $exit_code += 1
}

if (Is-UserEnabled $function2) {
    Write-Host "La fonctionnalité 27623730 est activée"
    $exit_code += 5
}
Pop-Location

# Vérification UCPD
$service = Get-Service -Name UCPD -ErrorAction Stop
if ($service.Status -ne 'Stopped') {
    Write-Host "Le service UCPD est toujours actif. Veuillez le désactiver en utilisant le bouton correspondant et en redémarrant la machine."
    $exit_code += 10
    
} else {
    
}
Write-Host "$exit_code"
exit $exit_code