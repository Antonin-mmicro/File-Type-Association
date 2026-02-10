$path = "$env:TEMP\ViveTool\"
$function1 = "43229420"
$function2 = "27623730"

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
function Is-UserEnabled($featureID) {
    $test = .\ViveTool.exe /query | Select-String -Pattern $featureID -Context 0,4
    # On ne regarde que le scope User
    $enabled = $test | ForEach-Object { $_.Line, $_.Context.PostContext } |
               Where-Object { $_ -match "Priority\s+: User" -and $_ -match "State\s+: Enabled \(2\)" }
    return ($enabled.Count -gt 0)
}

# Vérification pour 43229420
if (Is-UserEnabled $function1) {
    Write-Output "La fonctionnalité 43229420 est activée"
    Write-Host "Veuillez désactiver la rotation de hash en utilisant le bouton correspondant"
} else {
    
}

# Vérification pour 27623730
if (Is-UserEnabled $function2) {
    Write-Output "La fonctionnalité 27623730 est activée"
    Write-Host "Veuillez désactiver la rotation de hash en utilisant le bouton correspondant"
} else {
    
}
Pop-Location

# Vérification UCPD
$service = Get-Service -Name UCPD -ErrorAction Stop
if ($service.Status -ne 'Stopped') {
    Write-Host "Le service UCPD est toujours actif. Veuillez le désactiver en utilisant le bouton correspondant et en redémarrant la machine."
} else {
    
}