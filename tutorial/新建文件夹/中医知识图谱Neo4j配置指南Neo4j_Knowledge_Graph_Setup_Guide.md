# 中医知识图谱Neo4j配置指南

本指南将帮助您配置Neo4j Desktop以支持中医知识图谱功能，用于《伤寒论》六经辨证的AI诊断系统。

## 第一步：下载和安装Neo4j Desktop

1. 访问 [Neo4j官网](https://neo4j.com/download/)
2. 选择"Neo4j Desktop"版本
3. 下载适用于Windows的安装程序
4. 运行安装程序，按照向导完成安装

## 第二步：启动Neo4j Desktop

1. 安装完成后，启动Neo4j Desktop应用程序
2. 首次启动时可能需要注册账户，可以选择跳过
3. 在主界面点击"Add Graph"按钮创建新图数据库

## 第三步：创建新的本地图数据库

1. 选择"Create Local Graph"
2. 设置以下参数：
   - Graph Name: `TCM_Knowledge_Graph` （中医知识图谱）
   - Username: `neo4j`
   - Password: `your_password` （请设置一个安全的密码并记住）
   - Click "Create"按钮

## 第四步：启动数据库实例

1. 在图列表中找到刚创建的`TCM_Knowledge_Graph`
2. 点击"Start"按钮启动数据库
3. 等待状态变为"Running"（运行中）

## 第五步：配置数据库连接信息

在Neo4j运行后，您需要知道连接信息：

- **Bolt URL**: `bolt://localhost:7687`
- **Username**: `neo4j`
- **Password**: 您刚才设置的密码
- **HTTP URL**: `http://localhost:7687`

## 第六步：打开Neo4j浏览器

1. 数据库启动后，点击"Open"按钮进入Neo4j Browser
2. 浏览器会自动打开，显示Neo4j查询界面

## 第七步：创建中医知识图谱数据模型

在Neo4j浏览器中执行以下Cypher查询创建节点标签和关系类型：

```cypher
// 创建索引以提高查询性能
CREATE INDEX symptom_name_index FOR (s:Symptom) ON (s.name);
CREATE INDEX syndrome_name_index FOR (sy:Syndrome) ON (sy.name);
CREATE INDEX formula_name_index FOR (f:Formula) ON (f.name);
CREATE INDEX classic_name_index FOR (c:Classic) ON (c.name);
CREATE INDEX meridian_name_index FOR (m:Meridian) ON (m.name);

// 创建约束确保唯一性
CREATE CONSTRAINT symptom_unique_name IF NOT EXISTS FOR (s:Symptom) REQUIRE s.name IS UNIQUE;
CREATE CONSTRAINT syndrome_unique_name IF NOT EXISTS FOR (sy:Syndrome) REQUIRE sy.name IS UNIQUE;
CREATE CONSTRAINT formula_unique_name IF NOT EXISTS FOR (f:Formula) REQUIRE f.name IS UNIQUE;
```

## 第八步：导入中医知识数据

在Neo4j浏览器中执行以下Cypher查询导入基础中医知识：

```cypher
// 创建示例症状节点
CREATE (s1:Symptom {name: '恶寒', description: '怕冷的感觉'}),
       (s2:Symptom {name: '发热', description: '体温升高'}),
       (s3:Symptom {name: '无汗', description: '不出汗'}),
       (s4:Symptom {name: '头痛', description: '头部疼痛'}),
       (s5:Symptom {name: '身痛', description: '身体疼痛'}),
       (s6:Symptom {name: '汗出', description: '出汗'}),
       (s7:Symptom {name: '恶风', description: '怕风'}),
       (s8:Symptom {name: '往来寒热', description: '寒热交替'}),
       (s9:Symptom {name: '胸胁苦满', description: '胸胁部胀满不适'}),
       (s10:Symptom {name: '口苦', description: '口中苦味'});

// 创建示例证型节点
CREATE (sy1:Syndrome {name: '风寒表实证', description: '风寒外束，卫阳被遏'}),
       (sy2:Syndrome {name: '风寒表虚证', description: '营卫不和，卫外失司'}),
       (sy3:Syndrome {name: '少阳证', description: '邪犯少阳，枢机不利'});

// 创建示例方剂节点
CREATE (f1:Formula {name: '麻黄汤', description: '发汗解表，宣肺平喘'}),
       (f2:Formula {name: '桂枝汤', description: '解肌发表，调和营卫'}),
       (f3:Formula {name: '小柴胡汤', description: '和解少阳'});

// 创建示例经典条文节点
CREATE (c1:Classic {name: '伤寒论第35条', text: '太阳病，头痛发热，身疼腰痛，骨节疼痛，恶风无汗而喘者，麻黄汤主之。'}),
       (c2:Classic {name: '伤寒论第12条', text: '太阳中风，阳浮而阴弱，阳浮者，热自发；阴弱者，汗自出...'}),
       (c3:Classic {name: '伤寒论第96条', text: '伤寒五六日，中风，往来寒热，胸胁苦满，嘿嘿不欲饮食，心烦喜呕...'});

// 创建示例经络节点
CREATE (m1:Meridian {name: '太阳病', description: '膀胱经病变'}),
       (m2:Meridian {name: '阳明病', description: '胃大肠经病变'}),
       (m3:Meridian {name: '少阳病', description: '胆经病变'});

// 创建关系
CREATE (s1)-[:INDICATES]->(sy1),
       (s2)-[:INDICATES]->(sy1),
       (s3)-[:INDICATES]->(sy1),
       (s4)-[:INDICATES]->(sy1),
       (s5)-[:INDICATES]->(sy1),
       (s2)-[:INDICATES]->(sy2),
       (s6)-[:INDICATES]->(sy2),
       (s7)-[:INDICATES]->(sy2),
       (s8)-[:INDICATES]->(sy3),
       (s9)-[:INDICATES]->(sy3),
       (s10)-[:INDICATES]->(sy3);

CREATE (sy1)-[:HAS_FORMULA]->(f1),
       (sy2)-[:HAS_FORMULA]->(f2),
       (sy3)-[:HAS_FORMULA]->(f3);

CREATE (f1)-[:FROM_CLASSIC]->(c1),
       (f2)-[:FROM_CLASSIC]->(c2),
       (f3)-[:FROM_CLASSIC]->(c3);

CREATE (s1)-[:BELONGS_TO_MERIDIAN]->(m1),
       (s2)-[:BELONGS_TO_MERIDIAN]->(m1),
       (s3)-[:BELONGS_TO_MERIDIAN]->(m1),
       (s4)-[:BELONGS_TO_MERIDIAN]->(m1),
       (s5)-[:BELONGS_TO_MERIDIAN]->(m1),
       (s8)-[:BELONGS_TO_MERIDIAN]->(m3),
       (s9)-[:BELONGS_TO_MERIDIAN]->(m3),
       (s10)-[:BELONGS_TO_MERIDIAN]->(m3);
```

## 第九步：验证知识图谱

执行以下查询验证数据是否正确导入：

```cypher
// 查看所有症状
MATCH (s:Symptom) RETURN s.name;

// 查看所有证型
MATCH (sy:Syndrome) RETURN sy.name;

// 查看症状到证型的关系
MATCH (s:Symptom)-[:INDICATES]->(sy:Syndrome) 
RETURN s.name, sy.name 
LIMIT 10;

// 查看症状-证型-方剂的完整链路
MATCH (s:Symptom)-[:INDICATES]->(sy:Syndrome)-[:HAS_FORMULA]->(f:Formula) 
RETURN s.name, sy.name, f.name 
LIMIT 10;
```

## 第十步：配置中医系统连接

1. 在中医系统中，Neo4j连接信息将自动使用默认设置：
   - URI: `bolt://localhost:7687`
   - 用户名: `neo4j`
   - 密码: 您设置的密码

2. 系统会自动检测Neo4j服务并建立连接

## 故障排除

### 如果遇到连接问题：

1. **检查Neo4j是否运行**：
   - 确认Neo4j Desktop中的数据库实例状态为"Running"
   - 检查端口7687是否被占用

2. **重置密码**：
   - 如果忘记了密码，在Neo4j Browser中使用`:server change-password`命令

3. **防火墙设置**：
   - 确保Windows防火墙允许Neo4j的网络连接

### 性能优化：

1. 在生产环境中，可以考虑调整Neo4j的内存配置
2. 为频繁查询的字段创建合适的索引

## 扩展数据

您可以继续扩展知识图谱，添加更多：

- 症状节点：如口渴、便秘、腹痛等
- 证型节点：如阳明病证、太阴病证等
- 方剂节点：如白虎汤、承气汤等
- 经典条文：《伤寒论》中的其他条文
- 药物信息：方剂中的具体药物成分

## 验证AI功能

配置完成后，重启中医系统的AI API服务，它将自动连接到Neo4j并使用完整的知识图谱进行推理。

---

**注意**：如果您暂时无法安装Neo4j，系统也提供了基于规则的模拟功能，AI诊断模块仍可正常工作，只是推理能力基于内置规则而非图谱数据。

是的，Windows 10完全可以使用Neo4j社区服务器版！让我为您提供详细的信息：



```toolCall::search_web::call_0f70db95a7054871804c0098::INIT
```

是的，Windows 10完全可以使用Neo4j社区服务器版！以下是详细说明：

## Neo4j社区服务器版与Windows 10兼容性

✅ **完全兼容**：Neo4j社区服务器版可以在Windows 10上完美运行

## 安装方式

您有两种方式可以在Windows 10上安装Neo4j：

### 1. Neo4j Desktop（推荐新手）
- 图形化界面，易于管理
- 包含可视化浏览器
- 适合开发和测试

### 2. Neo4j服务器独立版
- 更适合生产环境
- 性能更好
- 可以作为Windows服务运行

## Windows 10系统要求

- **操作系统**：Windows 10（64位，版本1809或更高）
- **Java**：需要Java 11或Java 17（Neo4j 5.x版本）
- **内存**：建议至少8GB RAM
- **磁盘空间**：至少5GB可用空间

## 下载地址

您可以从Neo4j官网下载适合Windows的版本：
- Neo4j Desktop: https://neo4j.com/download/
- Neo4j Server: https://dist.neo4j.org/

## 在Windows 10上安装步骤

1. **下载Neo4j Desktop**
   - 访问Neo4j官网
   - 选择Desktop版本
   - 下载Windows安装程序(.exe)

2. **安装Java（如果尚未安装）**
   - Neo4j需要Java运行环境
   - 可以安装OpenJDK或Oracle JDK

3. **运行安装程序**
   - 双击下载的安装文件
   - 按照安装向导完成安装

4. **创建本地图数据库**
   - 启动Neo4j Desktop
   - 点击"Add Graph"
   - 选择"Create Local Graph"
   - 设置密码并启动数据库

## 与中医AI系统的集成

一旦在Windows 10上安装并启动Neo4j：
- 端口：7687（Bolt协议）
- 默认用户名：neo4j
- 您设置的密码
- 中医AI系统会自动检测并连接到Neo4j

## 注意事项

- 确保Windows防火墙允许Neo4j的端口通信
- 如果遇到权限问题，可以尝试以管理员身份运行安装程序
- Windows 10的WSL2（Windows Subsystem for Linux）也是一个很好的运行环境

所以您完全不用担心兼容性问题，Windows 10是Neo4j官方支持的操作系统之一！