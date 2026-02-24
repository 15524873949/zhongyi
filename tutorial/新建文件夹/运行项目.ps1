$condaEnvPath = "C:\ProgramData\miniconda3\envs\zhongyi-5.25.1119"
$scriptPath = $PSScriptRoot
$pythonFile = Join-Path $scriptPath "ZhongYi.py"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   清虚内守中医处方 - 运行项目" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Python 文件是否存在
if (-not (Test-Path $pythonFile)) {
    Write-Host "[错误] 找不到文件: $pythonFile" -ForegroundColor Red
    Read-Host "按 Enter 键退出"
    exit 1
}

# 检查 conda 环境是否存在
if (-not (Test-Path $condaEnvPath)) {
    Write-Host "[错误] conda 环境不存在: $condaEnvPath" -ForegroundColor Red
    Write-Host "请先运行启动开发环境.ps1" -ForegroundColor Yellow
    Read-Host "按 Enter 键退出"
    exit 1
}

Write-Host "正在启动项目..." -ForegroundColor Yellow
Write-Host ""

& "$condaEnvPath\python.exe" $pythonFile

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "[错误] 项目运行失败！" -ForegroundColor Red
    Write-Host ""
    Read-Host "按 Enter 键退出"
}