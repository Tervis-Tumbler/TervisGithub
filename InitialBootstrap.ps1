$PowerShellModulesPath = if ($env:PSModulePath -match ":") { 
    ($env:PSModulePath -split ":")[0]
} else {
    ($env:PSModulePath -split ";")[0]
}

New-Item $PowerShellModulesPath -ErrorAction SilentlyContinue -Type Directory
Set-Location $PowerShellModulesPath
git clone https://github.com/Tervis-Tumbler/TervisGithub
git clone https://github.com/Tervis-Tumbler/WebServicesPowerShellProxyBuilder

Invoke-TervisGithubPowerShellModulesSync

