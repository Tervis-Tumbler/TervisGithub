function Get-TervisGithubPowerShellModules {
    [CmdletBinding()]
    param(
        $PowerShellModulesPath = ($ENV:PSModulepath -split ";")[0]
    )
    Set-Location $PowerShellModulesPath

    $TervisPowerShellGitHubRepositories = Invoke-WebRequest -uri "https://api.github.com/search/repositories?q=language:powershell+user:tervis-tumbler&sort=stars&order=desc&per_page=100" -UseBasicParsing |
    select -ExpandProperty Content | 
    ConvertFrom-Json |
    select -ExpandProperty Items

    foreach($TervisPowerShellGitHubRepository in $TervisPowerShellGitHubRepositories) {
        $TervisPowerShellGitHubRepository.Name
        if (Test-Path $TervisPowerShellGitHubRepository.Name) {
            Write-Verbose "Pulling $TervisPowerShellGitHubRepository.Name"
            Push-Location $TervisPowerShellGitHubRepository.Name
            git pull
            Pop-Location
        } else {
            Write-Verbose "Cloning $TervisPowerShellGitHubRepository.Name"
            git clone $($TervisPowerShellGitHubRepository.clone_url)
        }
    }
}