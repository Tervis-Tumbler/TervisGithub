$PowerShellModulesPath = ($env:PSMODULEPATH -split {$_ -in ":",";"})[0]
mkdir $PowerShellModulesPath
cd $PowerShellModulesPath
git clone https://github.com/Tervis-Tumbler/TervisGithub

Get-TervisGithubPowerShellModules

