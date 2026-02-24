$condaEnvPath = "C:\ProgramData\miniconda3\envs\zhongyi-5.25.1119"
$scriptPath = $PSScriptRoot
$requirementsFile = Join-Path $scriptPath "requirements.txt"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   清虚内守中医处方 - 安装依赖" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# 检查 requirements.txt 是否存在
if (-not (Test-Path $requirementsFile)) {
    Write-Host "[错误] 找不到文件: $requirementsFile" -ForegroundColor Red
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

Write-Host "正在使用 conda 环境安装依赖..." -ForegroundColor Yellow
Write-Host "环境: zhongyi-5.25.1119" -ForegroundColor Gray
Write-Host ""

& "$condaEnvPath\python.exe" -m pip install -r $requirementsFile

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "[错误] 依赖安装失败！" -ForegroundColor Red
    Write-Host "请检查网络连接或 requirements.txt 内容。" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "按 Enter 键退出"
    exit 1
}

Write-Host ""
Write-Host "[成功] 依赖安装完成！" -ForegroundColor Green
Write-Host ""
Read-Host "按 Enter 键退出"