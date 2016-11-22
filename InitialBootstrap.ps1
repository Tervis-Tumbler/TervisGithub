$PowerShellModulesPath = if ($env:PSMODULEPATH -match ":") { 
    ($env:PSMODULEPATH -split ";")[0]
} else {
    ($env:PSMODULEPATH -split ":")[0]
}

New-Item $PowerShellModulesPath -ErrorAction SilentlyContinue -Type Directory
Set-Location $PowerShellModulesPath
git clone https://github.com/Tervis-Tumbler/TervisGithub

Get-TervisGithubPowerShellModules

