choco install github -y
choco install git -y

$PowerShellModulesPath = ($ENV:PSModulepath -split ";")[0]
cd $PowerShellModulesPath
git clone https://github.com/Tervis-Tumbler/TervisGithub

import-AllTervisGithubPowerShellModules