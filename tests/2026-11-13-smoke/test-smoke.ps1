#requires -Version 5.1
# DSH development-environment smoke test
# Exit code: 0 = pass, 1 = fail

$ErrorActionPreference = 'Continue'
$fail = 0
$warn = 0

function Write-Result {
    param([string]$Status, [string]$Name, [string]$Detail)
    Write-Output ("{0,-5} {1,-14} {2}" -f $Status, $Name, $Detail)
}

# PowerShell
Write-Result 'PASS' 'powershell' $PSVersionTable.PSVersion.ToString()

# Git
$gitVer = (& git --version 2>$null)
if ($LASTEXITCODE -eq 0 -and $gitVer) {
    Write-Result 'PASS' 'git' $gitVer
} else {
    Write-Result 'FAIL' 'git' 'git not found'
    $fail++
}

$name = (& git config user.name 2>$null)
$email = (& git config user.email 2>$null)
if ($name -and $email) {
    Write-Result 'PASS' 'git-identity' "$name <$email>"
} else {
    Write-Result 'FAIL' 'git-identity' 'user.name / user.email not configured'
    $fail++
}

if (& git rev-parse --is-inside-work-tree 2>$null) {
    $branch = (& git branch --show-current 2>$null)
    $remote = (& git remote get-url origin 2>$null)
    Write-Result 'PASS' 'repo' ("branch={0} origin={1}" -f $branch, $remote)
    $dirty = @(& git status --porcelain 2>$null)
    if ($dirty.Count -gt 0) {
        Write-Result 'WARN' 'worktree' ("{0} uncommitted change(s)" -f $dirty.Count)
        $warn++
    } else {
        Write-Result 'PASS' 'worktree' 'clean'
    }
} else {
    Write-Result 'WARN' 'repo' 'not a git repository (run from the repo root)'
    $warn++
}

# Node (optional)
$nodeVer = (& node --version 2>$null)
if ($LASTEXITCODE -eq 0 -and $nodeVer) {
    Write-Result 'PASS' 'node' $nodeVer
} else {
    Write-Result 'WARN' 'node' 'not installed or not in PATH'
    $warn++
}

# Python (optional)
$pyVer = (& python --version 2>&1)
if ($LASTEXITCODE -eq 0 -and $pyVer) {
    Write-Result 'PASS' 'python' ($pyVer -join ' ')
} else {
    Write-Result 'WARN' 'python' 'not installed or not in PATH'
    $warn++
}

Write-Output ''
if ($fail -gt 0) {
    Write-Output ("SMOKE FAILED (fail={0}, warn={1})" -f $fail, $warn)
    exit 1
}
Write-Output ("SMOKE OK (warn={0})" -f $warn)
exit 0
