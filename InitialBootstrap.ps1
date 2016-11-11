$PowerShellModulesPath = ($env:PSMODULEPATH -split {$_ -in ":",";"})[0]
New-Item $PowerShellModulesPath -ErrorAction SilentlyContinue
Set-Location $PowerShellModulesPath
git clone https://github.com/Tervis-Tumbler/TervisGithub

Get-TervisGithubPowerShellModules

