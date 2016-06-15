$GithubRootURL = "https://github.com/Tervis-Tumbler/"

$TervisGithubPowerShellModules = @"
TervisGithub
TervisKanbanize
New-MailToURI
get-MultipleChoiceQuestionAnswered
KanbanizePowerShell
TrackITWebAPIPowerShell
TrackITUnOfficial
InvokeSQL
TervisVirtualization
TervisEnvironment
TervisDHCP
TervisCluster
"@ -split "`r`n"

function import-AllTervisGithubPowerShellModules {
    $PowerShellModulesPath = ($ENV:PSModulepath -split ";")[0]
    cd $PowerShellModulesPath

    $TervisGithubPowerShellModules | % {
        git clone $($GithubRootURL + $_ + ".git")
    }
}

function Update-PowerShellModulesFromGit {

    $PowerShellModulesPath = ($ENV:PSModulepath -split ";")[0]
    $DirectoriesWithModules = gci $PowerShellModulesPath
    foreach ($Directory in $DirectoriesWithModules) {
        cd $Directory.FullName
        git pull
    }
    #(Get-Module -ListAvailable PowerShellIse*).path
}