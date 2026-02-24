$condaEnvPath = "C:\ProgramData\miniconda3\envs\zhongyi-5.25.1119"
$condaPath = "C:\ProgramData\miniconda3"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   清虚内守中医处方 - 开发环境" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# 检查 conda 环境是否存在
if (-not (Test-Path $condaEnvPath)) {
    Write-Host "[错误] conda 环境不存在: $condaEnvPath" -ForegroundColor Red
    Write-Host "请先创建环境: conda create -n zhongyi-5.25.1119 python=3.11" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "按 Enter 键退出"
    exit 1
}

Write-Host "正在激活 conda 环境: zhongyi-5.25.1119" -ForegroundColor Yellow
Write-Host ""

# 激活 conda 环境
& "$condaPath\Scripts\activate.bat" $condaEnvPath

Write-Host ""
Write-Host "[成功] 开发环境已激活！" -ForegroundColor Green
Write-Host ""
Write-Host "Python 版本:" -ForegroundColor Gray
& "$condaEnvPath\python.exe" --version
Write-Host ""
Write-Host "当前目录: $PWD" -ForegroundColor Gray
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " 可用命令:" -ForegroundColor Cyan
Write-Host "   pip install -r requirements.txt  (安装依赖)" -ForegroundColor White
Write-Host "   python ZhongYi.py                (运行项目)" -ForegroundColor White
Write-Host "   pip list                         (查看已安装包)" -ForegroundColor White
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "输入 'exit' 或关闭窗口退出环境" -ForegroundColor Gray
Write-Host ""

# 保持交互式会话
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")