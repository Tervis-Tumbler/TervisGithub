$PowerShellModulesPath = if ($env:PSModulePath -match ";") { 
    ($env:PSModulePath -split ";")[0]
} else {
    ($env:PSModulePath -split ":")[0]
}

New-Item $PowerShellModulesPath -ErrorAction SilentlyContinue -Type Directory
Set-Location $PowerShellModulesPath
[System.Net.ServicePointManager]::SecurityProtocol += [System.Net.SecurityProtocolType]::Tls12
git clone https://github.com/Tervis-Tumbler/TervisGithub
git clone https://github.com/Tervis-Tumbler/WebServicesPowerShellProxyBuilder
git clone https://github.com/Tervis-Tumbler/TervisMicrosoft.PowerShell.Utility

Invoke-TervisGithubPowerShellModulesSync

