我将为您逐行翻译这个文档，提供中英文对照。

首先，让我分析文档结构并进行翻译：



```toolCall::add_tasks::call_4123c38230f14c609235cfee::INIT
```



```toolCall::update_tasks::call_09b06df1aea04e9d8e03a814::INIT
```

好的，我将为您提供 [opsx.md](file:///E:/Programs/OpenSpec-main/docs/opsx.md) 文档的中英文对照逐行翻译：

# OPSX Workflow

> 反馈欢迎加入 [Discord](https://discord.gg/YctCnvvshC)。

## What Is It?

OPSX 现在是 OpenSpec 的标准工作流程。

这是一个用于 OpenSpec 更改的**灵活、迭代的工作流程**。不再有严格的阶段——而是您可以随时执行的操作。

## Why This Exists

传统 OpenSpec 工作流程可以运行，但它是**锁定的**：

- **指令是硬编码的**——埋在 TypeScript 中，您无法更改它们
- **全有或全无**——一个大命令创建所有内容，无法测试单个部分
- **固定结构**——对所有人使用相同的工作流程，无法自定义
- **黑盒**——当 AI 输出不佳时，您无法调整提示

**OPSX 打开了它。** 现在任何人都可以：

1. **试验指令**——编辑模板，看看 AI 是否表现更好
2. **细粒度测试**——独立验证每个工件的指令
3. **定制工作流程**——定义您自己的工件和依赖关系
4. **快速迭代**——更改模板，立即测试，无需重建

```
传统工作流程：                      OPSX：
┌────────────────────────┐           ┌────────────────────────┐
│  包含在包中（无法更改）  │           │  schema.yaml           │◄── 您编辑这个
│        ↓               │           │  templates/*.md        │◄── 或者这个
│  等待新版本发布        │           │        ↓               │
│        ↓               │           │  即时生效                │
│  希望它变得更好        │           │        ↓               │
└────────────────────────┘           │  自己测试它              │
                                    └────────────────────────┘
```

**这对每个人都有用：**
- **团队**——创建符合实际工作方式的工作流程
- **高级用户**——调整提示以获得更适合您的代码库的 AI 输出
- **OpenSpec 贡献者**——在不发布的情况下试验新方法

我们都在学习什么最有效。OPSX 让我们一起学习。

## The User Experience

**线性工作流程的问题：**
您处于"规划阶段"，然后"实现阶段"，然后"完成"。但实际工作并非如此。您实现某些内容后，意识到设计有误，需要更新规格，继续实现。线性阶段与实际工作方式相冲突。

**OPSX 方法：**
- **操作，而不是阶段**——创建、实现、更新、归档——随时执行任何操作
- **依赖项是推动因素**——它们显示了可能性，而不是下一步必需的内容

```
  proposal ──→ specs ──→ design ──→ tasks ──→ implement
  提案        ──→ 规格  ──→ 设计  ──→ 任务   ──→ 实现
```

## Setup

```bash
# 确保您已安装 openspec —— 技能会自动生成
openspec init
```

这会在 `.claude/skills/`（或等效位置）中创建 AI 编码助手自动检测的技能。

默认情况下，OpenSpec 使用 `core` 工作流程配置文件（`propose`、`explore`、`apply`、`archive`）。如果您想要扩展工作流命令（`new`、`continue`、`ff`、`verify`、`sync`、`bulk-archive`、`onboard`），请使用 `openspec config profile` 进行配置，并使用 `openspec update` 应用。

在设置过程中，系统会提示您创建一个**项目配置**（`openspec/config.yaml`）。这是可选的，但建议使用。

## Project Configuration

项目配置允许您设置默认值并将特定于项目的上下文注入到所有工件中。

### Creating Config

配置在 `openspec init` 期间创建，或手动创建：

```yaml
# openspec/config.yaml
schema: spec-driven

context: |
  技术栈：TypeScript, React, Node.js
  API 约定：RESTful, JSON 响应
  测试：Vitest 进行单元测试, Playwright 进行端到端测试
  样式：ESLint 配合 Prettier, 严格 TypeScript

rules:
  proposal:
    - 包含回滚计划
    - 识别受影响的团队
  specs:
    - 使用 Given/When/Then 格式编写场景
  design:
    - 在复杂流程中包含序列图
```

### Config Fields

| 字段 | 类型 | 描述 |
|-------|------|-------------|
| [schema](file://e:\Programs\OpenSpec-main\src\commands\schema.ts#L177-L177) | string | 新变更的默认模式（例如 `spec-driven`）|
| [context](file://e:\Programs\OpenSpec-main\src\commands\workflow\instructions.ts#L312-L312) | string | 注入到所有工件指令中的项目上下文 |
| [rules](file://e:\Programs\OpenSpec-main\src\core\artifact-graph\instruction-loader.ts#L64-L64) | object | 按工件 ID 分组的特定工件规则 |

### How It Works

**模式优先级**（从高到低）：
1. CLI 标志（`--schema <name>`）
2. 变更元数据（变更目录中的 [.openspec.yaml](file:///E:/Programs/OpenSpec-main/.openspec.yaml)）
3. 项目配置（`openspec/config.yaml`）
4. 默认值（`spec-driven`）

**上下文注入：**
- 上下文被添加到每个工件指令的开头
- 用 `<context>...</context>` 标签包装
- 帮助 AI 理解您的项目约定

**规则注入：**
- 规则仅针对匹配的工件注入
- 用 `<rules>...</rules>` 标签包装
- 出现在上下文之后，模板之前

### Artifact IDs by Schema

**spec-driven**（默认）：
- `proposal` — 变更提案
- [specs](file://e:\Programs\OpenSpec-main\src\commands\validate.ts#L12-L12) — 规格说明
- `design` — 技术设计
- [tasks](file://e:\Programs\OpenSpec-main\src\commands\workflow\shared.ts#L33-L33) — 实施任务

### Config Validation

- [rules](file://e:\Programs\OpenSpec-main\src\core\artifact-graph\instruction-loader.ts#L64-L64) 中未知的工件 ID 会产生警告
- 模式名称根据可用模式进行验证
- 上下文限制为 50KB
- 无效的 YAML 会报告行号

### Troubleshooting

**"Unknown artifact ID in rules: X"**
- 检查工件 ID 是否与您的模式匹配（参见上面的列表）
- 运行 `openspec schemas --json` 查看每种模式的工件 ID

**配置未应用：**
- 确保文件位于 `openspec/config.yaml`（不是 .yml）
- 使用验证器检查 YAML 语法
- 配置更改立即生效（无需重启）

**上下文太大：**
- 上下文限制为 50KB
- 改为摘要或链接到外部文档

## Commands

| 命令 | 功能 |
|---------|--------------|
| `/opsx:propose` | 创建变更并在一步中生成规划工件（默认快捷路径）|
| `/opsx:explore` | 思考想法，研究问题，明确需求 |
| `/opsx:new` | 启动新的变更脚手架（扩展工作流）|
| `/opsx:continue` | 创建下一个工件（扩展工作流）|
| `/opsx:ff` | 快速前进规划工件（扩展工作流）|
| `/opsx:apply` | 实施任务，根据需要更新工件 |
| `/opsx:verify` | 验证实施是否符合工件（扩展工作流）|
| `/opsx:sync` | 同步增量规格到主干（扩展工作流，可选）|
| `/opsx:archive` | 完成后归档 |
| `/opsx:bulk-archive` | 归档多个已完成的变更（扩展工作流）|
| `/opsx:onboard` | 引导式端到端变更演练（扩展工作流）|

## Usage

### Explore an idea
```
/opsx:explore
```
思考想法，研究问题，比较选项。不需要结构 - 只是一个思考伙伴。当见解清晰时，转换到 `/opsx:propose`（默认）或 `/opsx:new`/`/opsx:ff`（扩展）。

### Start a new change
```
/opsx:propose
```
创建变更并生成实施前所需的规划工件。

如果启用了扩展工作流，则可以改为使用：

```text
/opsx:new        # 仅脚手架
/opsx:continue   # 一次创建一个工件
/opsx:ff         # 一次性创建所有规划工件
```

### Create artifacts
```
/opsx:continue
```
显示基于依赖关系准备创建的内容，然后创建一个工件。重复使用以逐步构建您的变更。

```
/opsx:ff add-dark-mode
```
一次性创建所有规划工件。当您清楚要构建的内容时使用。

### Implement (the fluid part)
```
/opsx:apply
```
处理任务，在完成时勾选它们。如果您同时处理多个变更，可以运行 `/opsx:apply <name>`；否则它应该从对话中推断并在无法确定时提示您选择。

### Finish up
```
/opsx:archive   # 完成后移动到归档（如果需要，会提示同步规格）
```

## When to Update vs. Start Fresh

在实施之前，您可以随时编辑提案或规格。但是什么时候精炼变成了"这是不同的工作"？

### What a Proposal Captures

提案定义三件事：
1. **意图**——您要解决什么问题？
2. **范围**——什么是包含/排除的？
3. **方法**——您将如何解决它？

问题是：哪些改变了，以及改变了多少？

### Update the Existing Change When:

**相同意图，完善执行**
- 您发现了没有考虑的边缘情况
- 方法需要微调但目标不变
- 实施揭示设计略有偏差

**范围缩小**
- 您意识到完整范围太大，想先交付最小可行产品
- "添加暗色模式" → "添加暗色模式切换（系统偏好设置在 v2 中）"

**基于学习的修正**
- 代码库结构不像您想象的那样
- 依赖项不起作用如预期
- "使用 CSS 变量" → "改用 Tailwind 的 dark: 前缀"

### Start a New Change When:

**意图根本改变**
- 问题本身现在不同了
- "添加暗色模式" → "添加具有自定义颜色、字体、间距的综合主题系统"

**范围激增**
- 变更增长得如此之多，本质上是不同的工作
- 原始提案在更新后将面目全非
- "修复登录错误" → "重写认证系统"

**原始内容可完成**
- 原始变更可以标记为"完成"
- 新工作独立存在，不是改进
- 完成"添加暗色模式 MVP" → 归档 → 新变更"增强暗色模式"

### The Heuristics

```
                        ┌─────────────────────────────────────┐
                        │     这是相同的工作吗？               │
                        └──────────────┬──────────────────────┘
                                       │
                    ┌──────────────────┼──────────────────┐
                    │                  │                  │
                    ▼                  ▼                  ▼
             相同意图？          >50% 重叠？      原始内容是否
             相同问题？         相同范围？        不做这些更改
                    │                  │          就能"完成"？
                    │                  │                  │
          ┌────────┴────────┐  ┌──────┴──────┐   ┌───────┴───────┐
          │                 │  │             │   │               │
         是                否  是            否  否              是
          │                 │  │             │   │               │
          ▼                 ▼  ▼             ▼   ▼               ▼
       更新              新变更  更新         新变更  更新           新变更
```

| 测试 | 更新 | 新变更 |
|------|--------|------------|
| **身份** | "同一事物，完善" | "不同工作" |
| **范围重叠** | >50% 重叠 | <50% 重叠 |
| **完成度** | 没有这些更改无法"完成" | 可以完成原始内容，新工作独立存在 |
| **故事** | 更新链讲述连贯的故事 | 补丁会比澄清更令人困惑 |

### The Principle

> **更新保留上下文。新变更提供清晰度。**
>
> 当您的思维历史有价值时选择更新。
> 当从头开始会比修补更清晰时选择新变更。

将其视为 git 分支：
- 在处理同一功能时继续提交
- 当确实是新工作时启动新分支
- 有时合并部分功能并为第二阶段从头开始

## What's Different?

| | 传统（`/openspec:proposal`） | OPSX（`/opsx:*`） |
|---|---|---|
| **结构** | 一个大提案文档 | 具有依赖关系的离散工件 |
| **工作流程** | 线性阶段：计划 → 实施 → 归档 | 流体操作——随时执行任何操作 |
| **迭代** | 回退很尴尬 | 在学习时更新工件 |
| **自定义** | 固定结构 | 模式驱动（定义自己的工件） |

**关键洞察：** 工作不是线性的。OPSX 停止假装它是线性的。

## Architecture Deep Dive

本节解释了 OPSX 如何在幕后工作以及它与传统工作流程的比较。
本节中的示例使用扩展命令集（`new`、`continue` 等）；默认 `core` 用户可以将相同流程映射到 `propose → apply → archive`。

### Philosophy: Phases vs Actions

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         传统工作流程                                        │
│                    （阶段锁定，全有或全无）                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌──────────────┐      ┌──────────────┐      ┌──────────────┐             │
│   │   规划       │ ───► │   实施       │ ───► │   归档       │             │
│   │    阶段      │      │    阶段      │      │    阶段      │             │
│   └──────────────┘      └──────────────┘      └──────────────┘             │
│         │                     │                     │                       │
│         ▼                     ▼                     ▼                       │
│   /openspec:proposal   /openspec:apply      /openspec:archive              │
│                                                                             │
│   • 一次性创建所有工件                                                     │
│   • 在实施过程中无法返回更新规格                                           │
│   • 阶段网关强制线性进展                                                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘


┌─────────────────────────────────────────────────────────────────────────────┐
│                            OPSX 工作流程                                    │
│                      （流体操作，迭代）                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│              ┌────────────────────────────────────────────┐                 │
│              │           操作（非阶段）                    │                 │
│              │                                            │                 │
│              │   new ◄──► continue ◄──► apply ◄──► archive │                 │
│              │    │          │           │           │    │                 │
│              │    └──────────┴───────────┴───────────┘    │                 │
│              │              任意顺序                        │                 │
│              └────────────────────────────────────────────┘                 │
│                                                                             │
│   • 一次创建一个工件或快进                                                  │
│   • 在实施过程中更新规格/设计/任务                                          │
│   • 依赖项推动进展，不存在阶段                                              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Component Architecture

**传统工作流程** 使用硬编码模板（TypeScript 字符串）：

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                      传统工作流程组件                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   硬编码模板（TypeScript 字符串）                                           │
│                    │                                                        │
│                    ▼                                                        │
│   特定工具的配置器/适配器                                                   │
│                    │                                                        │
│                    ▼                                                        │
│   生成的命令文件（.claude/commands/openspec/*.md）                          │
│                                                                             │
│   • 固定结构，无工件感知                                                  │
│   • 更改需要代码修改+重建                                                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

**OPSX** 使用外部模式和依赖图引擎：

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         OPSX 组件                                           │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   模式定义（YAML）                                                          │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │  name: spec-driven                                                  │   │
│   │  artifacts:                                                         │   │
│   │    - id: proposal                                                   │   │
│   │      generates: proposal.md                                         │   │
│   │      requires: []              ◄── 依赖关系                         │   │
│   │    - id: specs                                                      │   │
│   │      generates: specs/**/*.md  ◄── 通配符模式                       │   │
│   │      requires: [proposal]      ◄── 在提案后启用                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                    │                                                        │
│                    ▼                                                        │
│   工件图引擎                                                                │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │  • 拓扑排序（依赖排序）                                             │   │
│   │  • 状态检测（文件系统存在性）                                       │   │
│   │  • 丰富的指令生成（模板+上下文）                                    │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                    │                                                        │
│                    ▼                                                        │
│   技能文件（.claude/skills/openspec-*/SKILL.md）                            │
│                                                                             │
│   • 跨编辑器兼容（Claude Code, Cursor, Windsurf）                           │
│   • 技能查询 CLI 获取结构化数据                                             │
│   • 通过模式文件完全可定制                                                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Dependency Graph Model

工件形成一个有向无环图（DAG）。依赖关系是**推动因素**，而非障碍：

```
                              proposal
                              (根节点)
                                  │
                    ┌─────────────┴─────────────┐
                    │                           │
                    ▼                           ▼
                 specs                       design
              (requires:                  (requires:
               proposal)                   proposal)
                    │                           │
                    └─────────────┬─────────────┘
                                  │
                                  ▼
                               tasks
                           (requires:
                           specs, design)
                                  │
                                  ▼
                          ┌──────────────┐
                          │ 实施阶段     │
                          │ (requires:   │
                          │  tasks)      │
                          └──────────────┘
```

**状态转换：**

```
   阻塞 ────────────────► 准备 ────────────────► 完成
      │                        │                       │
   缺少依赖项                 所有依赖项               文件存在于
                            都已完成                 文件系统中
```

### Information Flow

**传统工作流程**——代理接收静态指令：

```
  用户: "/openspec:proposal"
           │
           ▼
  ┌─────────────────────────────────────────┐
  │  静态指令：                              │
  │  • 创建 proposal.md                      │
  │  • 创建 tasks.md                         │
  │  • 创建 design.md                        │
  │  • 创建 specs/<capability>/spec.md       │
  │                                         │
  │  不了解存在的内容或工件间的依赖关系        │
  └─────────────────────────────────────────┘
           │
           ▼
  代理一次性创建所有工件
```

**OPSX**——代理查询丰富上下文：

```
  用户: "/opsx:continue"
           │
           ▼
  ┌──────────────────────────────────────────────────────────────────────────┐
  │  步骤 1: 查询当前状态                                                      │
  │  ┌────────────────────────────────────────────────────────────────────┐  │
  │  │  $ openspec status --change "add-auth" --json                      │  │
  │  │                                                                    │  │
  │  │  {                                                                 │  │
  │  │    "artifacts": [                                                  │  │
  │  │      {"id": "proposal", "status": "done"},                         │  │
  │  │      {"id": "specs", "status": "ready"},      ◄── 第一个就绪       │  │
  │  │      {"id": "design", "status": "ready"},                          │  │
  │  │      {"id": "tasks", "status": "blocked", "missingDeps": ["specs"]}│  │
  │  │    ]                                                               │  │
  │  │  }                                                                 │  │
  │  └────────────────────────────────────────────────────────────────────┘  │
  │                                                                          │
  │  步骤 2: 获取就绪工件的丰富指令                                              │
  │  ┌────────────────────────────────────────────────────────────────────┐  │
  │  │  $ openspec instructions specs --change "add-auth" --json          │  │
  │  │                                                                    │  │
  │  │  {                                                                 │  │
  │  │    "template": "# Specification\n\n## ADDED Requirements...",      │  │
  │  │    "dependencies": [{"id": "proposal", "path": "...", "done": true}│  │
  │  │    "unlocks": ["tasks"]                                            │  │
  │  │  }                                                                 │  │
  │  └────────────────────────────────────────────────────────────────────┘  │
  │                                                                          │
  │  步骤 3: 读取依赖项 → 创建一个工件 → 显示解锁内容                          │
  └──────────────────────────────────────────────────────────────────────────┘
```

### Iteration Model

**传统工作流程**——迭代困难：

```
  ┌─────────┐     ┌─────────┐     ┌─────────┐
  │/proposal│ ──► │ /apply  │ ──► │/archive │
  └─────────┘     └─────────┘     └─────────┘
       │               │
       │               ├── "等等，设计错了"
       │               │
       │               ├── 选项：
       │               │   • 手动编辑文件（破坏上下文）
       │               │   • 放弃并重新开始
       │               │   • 继续推进并在稍后修复
       │               │
       │               └── 没有官方的"返回"机制
       │
       └── 一次性创建所有工件
```

**OPSX**——自然迭代：

```
  /opsx:new ───► /opsx:continue ───► /opsx:apply ───► /opsx:archive
      │                │                  │
      │                │                  ├── "设计错了"
      │                │                  │
      │                │                  ▼
      │                │            只需编辑 design.md
      │                │            并继续！
      │                │                  │
      │                │                  ▼
      │                │         /opsx:apply 从离开的地方继续
      │                │
      │                └── 创建一个工件，显示解锁内容
      │
      └── 脚手架变更，等待方向
```

### Custom Schemas

使用模式管理命令创建自定义工作流：

```bash
# 从头创建新模式（交互式）
openspec schema init my-workflow

# 或分叉现有模式作为起点
openspec schema fork spec-driven my-workflow

# 验证模式结构
openspec schema validate my-workflow

# 查看模式解析位置（调试有用）
openspec schema which my-workflow
```

模式存储在 `openspec/schemas/`（项目本地，版本控制）或 `~/.local/share/openspec/schemas/`（用户全局）。

**模式结构：**
```
openspec/schemas/research-first/
├── schema.yaml
└── templates/
    ├── research.md
    ├── proposal.md
    └── tasks.md
```

**示例 schema.yaml：**
```yaml
name: research-first
artifacts:
  - id: research        # 在提案之前添加
    generates: research.md
    requires: []

  - id: proposal
    generates: proposal.md
    requires: [research]  # 现在依赖于研究

  - id: tasks
    generates: tasks.md
    requires: [proposal]
```

**依赖图：**
```
   research ──► proposal ──► tasks
   研究      ──► 提案    ──► 任务
```

### Summary

| 方面 | 传统 | OPSX |
|--------|----------|------|
| **模板** | 硬编码 TypeScript | 外部 YAML + Markdown |
| **依赖关系** | 无（全部一起） | 具有拓扑排序的 DAG |
| **状态** | 基于阶段的心理模型 | 文件系统存在性 |
| **自定义** | 编辑源代码，重建 | 创建 schema.yaml |
| **迭代** | 阶段锁定 | 流体，编辑任何内容 |
| **编辑器支持** | 特定工具的配置器/适配器 | 单一技能目录 |

## Schemas

模式定义了工件的存在及其依赖关系。目前可用：

- **spec-driven**（默认）：proposal → specs → design → tasks

```bash
# 列出可用模式
openspec schemas

# 查看所有模式及其解析源
openspec schema which --all

# 交互式创建新模式
openspec schema init my-workflow

# 分叉现有模式进行自定义
openspec schema fork spec-driven my-workflow

# 使用前验证模式结构
openspec schema validate my-workflow
```

## Tips

- 在提交变更之前使用 `/opsx:explore` 思考想法
- 当您知道想要什么时使用 `/opsx:ff`，探索时使用 `/opsx:continue`
- 在 `/opsx:apply` 期间，如果有问题——修复工件，然后继续
- 任务通过 [tasks.md](file://e:\Programs\OpenSpec-main\openspec\changes\add-global-install-scope\tasks.md) 中的复选框跟踪进度
- 随时检查状态：`openspec status --change "name"`

## Feedback

这是粗糙的。这是有意的——我们正在学习什么有效。

发现问题了吗？有想法吗？加入我们的 [Discord](https://discord.gg/YctCnvvshC) 或在 [GitHub](https://github.com/Fission-AI/openspec/issues) 上开问题。