function Get-TervisGithubPowerShellModules {
    param(
        $PowerShellModulesPath = ($ENV:PSModulepath -split ";")[0]
    )
    Set-Location $PowerShellModulesPath

    $TervisPowerShellGitHubRepositories = Invoke-WebRequest -uri "https://api.github.com/search/repositories?q=language:powershell+user:tervis-tumbler&sort=stars&order=desc" |
    select -ExpandProperty Content | 
    ConvertFrom-Json |
    select -ExpandProperty Items

    foreach($TervisPowerShellGitHubRepository in $TervisPowerShellGitHubRepositories) {
        if (Test-Path $TervisPowerShellGitHubRepository.Name) {
            Push-Location $TervisPowerShellGitHubRepository.Name
            git pull
            Pop-Location
        } else {
            git clone $($TervisPowerShellGitHubRepository.clone_url)
        }
    }
}