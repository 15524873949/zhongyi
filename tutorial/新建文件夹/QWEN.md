# 中医处方管理系统

## 项目概述

这是一个名为"清虚内守中医处方"的中医处方管理软件，使用Python和PySide6开发的桌面应用程序。该软件专为中医师设计，用于管理患者病历、开具处方、记录针灸治疗等。软件采用模块化架构，支持与MySQL/MariaDB数据库交互，具备患者信息管理、病历记录、处方管理、诊断分析等功能。

该项目是基于广东惠州龙门沙迳人氏中医师陈焕林先生的"中医处方系统"重新设计开发的现代化版本，解决了原系统在Windows 7/10系统上无法正常运行的问题。

## 技术栈

- **编程语言**: Python 3.8.10
- **GUI框架**: PySide6 (LGPLv3)
- **数据库**: MySQL/MariaDB
- **数据库连接**: PyMySQL (MIT)
- **加密库**: PyCryptodome (BSD)
- **中文处理**: pypinyin (MIT)
- **PDF处理**: pypdfium2 (Apache 2.0)
- **报表生成**: reportlab (BSD)

## 主要功能

### 核心功能
- 用户登录认证（密码加密存储）
- 患者信息管理（姓名、性别、年龄、联系方式等）
- 病历记录（初诊、复诊）
- 中药处方管理（药物选择、剂量调整、价格计算）
- 针灸治疗记录
- 诊断分析与辩证选方
- 病证症状管理
- 医案心得记录

### 特色功能
- 拼音首字母快速检索（支持中文姓名、诊断等的拼音检索）
- 患者对比功能（高亮显示病历差异）
- 图片嵌入（患者照片、病证图片）
- 自动计价功能（中药、针灸、诊金）
- 界面伸缩与板块拖拽隐藏
- 数据导出与打印（PDF格式）
- 数据库加密连接

## 项目结构

```
E:\Programs\zhongyi-5.25.1119\
├── ZhongYi.py                 # 主入口文件，登录界面
├── main_window_system.py      # 主窗口系统
├── Database_connection.py     # 数据库连接配置
├── DatabaseUtil.py           # 数据库操作工具类
├── ui_*.py                   # Qt Designer生成的界面文件
├── *_window.py               # 各功能模块窗口实现
├── requirements.txt          # 项目依赖
├── README.md                 # 项目说明
├── 更新日志.txt              # 开发日志
├── tutorial/                 # 教程文档
│   ├── 使用教程.pdf
│   └── 说明.txt
├── Assets/                   # 资源文件
└── *.sql                     # 数据库结构文件
```

## 构建和运行

### 环境要求
- Python 3.8.10
- MariaDB或MySQL数据库

### 安装步骤
1. 安装Python 3.8.10和MariaDB/MySQL数据库
2. 安装依赖包：
   ```bash
   pip install -r requirements.txt
   ```
3. 配置数据库并导入SQL文件（zy.sql或chl.sql）
4. 运行主程序：
   ```bash
   python ZhongYi.py
   ```

### 运行脚本
项目提供了PowerShell脚本：
- `安装依赖.ps1` - 安装项目依赖
- `启动开发环境.ps1` - 启动开发环境
- `运行项目.ps1` - 运行项目

## 开发约定

### 代码规范
- 使用PySide6进行GUI开发
- 数据库操作通过DatabaseUtil类封装
- 界面与业务逻辑分离
- 中文字符处理使用pypinyin库

### 数据库设计
- 使用MySQL/MariaDB数据库
- 数据库连接信息加密存储在Link_loop.enc文件中
- 支持中文字符集（utf8mb4）

### 安全措施
- 用户密码加密存储
- 数据库连接信息加密
- 防止SQL注入（使用参数化查询）

## 许可证

该项目使用多种开源许可证的组件：
- PySide6: LGPLv3
- PyMySQL: MIT
- pypinyin: MIT
- PyCryptodome: BSD
- Source Han Sans CN: SIL OFL 1.1

整体软件为免费开源软件，专为中医师设计，无任何功能限制。

## 注意事项

1. 软件需要配合数据库使用，首次运行需要配置数据库连接
2. 提供了空白数据库（zy.sql）和带示例数据的数据库（chl.sql）
3. 建议使用HeidiSQL或Navicat进行数据库管理
4. 定期备份数据库以防数据丢失
5. 软件支持Windows 7/10 64位系统