$PowerShellModulesPath = ($ENV:PSModulepath -split ";")[0]
mkdir $PowerShellModulesPath
cd $PowerShellModulesPath
git clone https://github.com/Tervis-Tumbler/TervisGithub

import-AllTervisGithubPowerShellModules

