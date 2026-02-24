// 中医知识图谱创建脚本
// 用于《伤寒论》六经辨证AI诊断系统

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
       (s10:Symptom {name: '口苦', description: '口中苦味'}),
       (s11:Symptom {name: '咽干', description: '咽喉干燥'}),
       (s12:Symptom {name: '目眩', description: '眼睛昏花'}),
       (s13:Symptom {name: '腹满', description: '腹部胀满'}),
       (s14:Symptom {name: '呕吐', description: '恶心呕吐'}),
       (s15:Symptom {name: '食欲不振', description: '不想吃饭'}),
       (s16:Symptom {name: '腹痛', description: '腹部疼痛'}),
       (s17:Symptom {name: '四肢厥冷', description: '手脚冰凉'}),
       (s18:Symptom {name: '精神萎靡', description: '精神不振'}),
       (s19:Symptom {name: '脉微细', description: '脉搏微弱细微'}),
       (s20:Symptom {name: '头晕', description: '头部晕眩'}),
       (s21:Symptom {name: '胸闷', description: '胸部憋闷'}),
       (s22:Symptom {name: '心烦', description: '心情烦躁'}),
       (s23:Symptom {name: '心悸', description: '心跳加速'}),
       (s24:Symptom {name: '失眠', description: '睡不着觉'}),
       (s25:Symptom {name: '盗汗', description: '夜间出汗'}),
       (s26:Symptom {name: '口渴', description: '口干想喝水'}),
       (s27:Symptom {name: '便秘', description: '大便干结'}),
       (s28:Symptom {name: '腹泻', description: '拉肚子'});

// 创建示例证型节点
CREATE (sy1:Syndrome {name: '风寒表实证', description: '风寒外束，卫阳被遏'}),
       (sy2:Syndrome {name: '风寒表虚证', description: '营卫不和，卫外失司'}),
       (sy3:Syndrome {name: '少阳证', description: '邪犯少阳，枢机不利'}),
       (sy4:Syndrome {name: '阳明经证', description: '胃热弥漫，无形热盛'}),
       (sy5:Syndrome {name: '阳明腑证', description: '肠胃燥热，有形热结'}),
       (sy6:Syndrome {name: '太阴病', description: '脾阳虚衰，寒湿内停'}),
       (sy7:Syndrome {name: '少阴病', description: '心肾虚衰，全身机能衰退'}),
       (sy8:Syndrome {name: '厥阴病', description: '阴阳失调，寒热错杂'});

// 创建示例方剂节点
CREATE (f1:Formula {name: '麻黄汤', description: '发汗解表，宣肺平喘', category: '解表剂'}),
       (f2:Formula {name: '桂枝汤', description: '解肌发表，调和营卫', category: '解表剂'}),
       (f3:Formula {name: '小柴胡汤', description: '和解少阳', category: '和解剂'}),
       (f4:Formula {name: '白虎汤', description: '清热生津', category: '清热剂'}),
       (f5:Formula {name: '大承气汤', description: '峻下热结', category: '泻下剂'}),
       (f6:Formula {name: '理中丸', description: '温中祛寒，补气健脾', category: '温里剂'}),
       (f7:Formula {name: '四逆汤', description: '回阳救逆', category: '温里剂'}),
       (f8:Formula {name: '乌梅丸', description: '缓肝调中，清上温下', category: '驱虫剂'});

// 创建示例经典条文节点
CREATE (c1:Classic {name: '伤寒论第35条', text: '太阳病，头痛发热，身疼腰痛，骨节疼痛，恶风无汗而喘者，麻黄汤主之。'}),
       (c2:Classic {name: '伤寒论第12条', text: '太阳中风，阳浮而阴弱，阳浮者，热自发；阴弱者，汗自出，啬啬恶寒，淅淅恶风，翕翕发热，鼻鸣干呕者，桂枝汤主之。'}),
       (c3:Classic {name: '伤寒论第96条', text: '伤寒五六日，中风，往来寒热，胸胁苦满，嘿嘿不欲饮食，心烦喜呕，或胸中烦而不呕，或渴，或腹中痛，或胁下痞硬，或心下悸、小便不利，或不渴、身有微热，或咳者，小柴胡汤主之。'}),
       (c4:Classic {name: '伤寒论第168条', text: '伤寒若吐若下后，七八日不解，热结在里，表里俱热，时时恶风，大渴，舌上干燥而烦，欲饮水数升者，白虎加人参汤主之。'}),
       (c5:Classic {name: '伤寒论第251条', text: '得病二三日，脉弱，无太阳柴胡证，烦躁，心下硬，至四五日，虽能食，以小承气汤，少少与，微和之，令小安。'}),
       (c6:Classic {name: '伤寒论第386条', text: '霍乱，头痛发热，身疼痛，热多欲饮水者，五苓散主之；寒多不用水者，理中丸主之。'}),
       (c7:Classic {name: '伤寒论第323条', text: '少阴病，脉沉者，急温之，宜四逆汤。'}),
       (c8:Classic {name: '伤寒论第338条', text: '伤寒脉微而厥，至七八日肤冷，其人躁，无暂安时者，此为脏厥，非蛔厥也。蛔厥者，其人当吐蛔。今病者静，而复时烦者，此为脏寒。蛔上入其膈，故烦，须臾复止；得食而呕又烦者，蛔闻食臭出，其人常自吐蛔。蛔厥者，乌梅丸主之。又主久利。'});

// 创建示例经络节点
CREATE (m1:Meridian {name: '太阳病', description: '膀胱经病变', category: '六经'}),
       (m2:Meridian {name: '阳明病', description: '胃大肠经病变', category: '六经'}),
       (m3:Meridian {name: '少阳病', description: '胆经病变', category: '六经'}),
       (m4:Meridian {name: '太阴病', description: '脾经病变', category: '六经'}),
       (m5:Meridian {name: '少阴病', description: '肾经病变', category: '六经'}),
       (m6:Meridian {name: '厥阴病', description: '肝经病变', category: '六经'});

// 创建症状到证型的关系
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
       (s10)-[:INDICATES]->(sy3),
       (s11)-[:INDICATES]->(sy3),
       (s12)-[:INDICATES]->(sy3),
       (s26)-[:INDICATES]->(sy4),
       (s27)-[:INDICATES]->(sy5),
       (s13)-[:INDICATES]->(sy6),
       (s14)-[:INDICATES]->(sy6),
       (s15)-[:INDICATES]->(sy6),
       (s17)-[:INDICATES]->(sy7),
       (s18)-[:INDICATES]->(sy7),
       (s19)-[:INDICATES]->(sy7),
       (s20)-[:INDICATES]->(sy8),
       (s21)-[:INDICATES]->(sy8),
       (s22)-[:INDICATES]->(sy8);

// 创建证型到方剂的关系
CREATE (sy1)-[:HAS_FORMULA]->(f1),
       (sy2)-[:HAS_FORMULA]->(f2),
       (sy3)-[:HAS_FORMULA]->(f3),
       (sy4)-[:HAS_FORMULA]->(f4),
       (sy5)-[:HAS_FORMULA]->(f5),
       (sy6)-[:HAS_FORMULA]->(f6),
       (sy7)-[:HAS_FORMULA]->(f7),
       (sy8)-[:HAS_FORMULA]->(f8);

// 创建方剂到经典的关联
CREATE (f1)-[:FROM_CLASSIC]->(c1),
       (f2)-[:FROM_CLASSIC]->(c2),
       (f3)-[:FROM_CLASSIC]->(c3),
       (f4)-[:FROM_CLASSIC]->(c4),
       (f5)-[:FROM_CLASSIC]->(c5),
       (f6)-[:FROM_CLASSIC]->(c6),
       (f7)-[:FROM_CLASSIC]->(c7),
       (f8)-[:FROM_CLASSIC]->(c8);

// 创建症状到经络的关系
CREATE (s1)-[:BELONGS_TO_MERIDIAN]->(m1),
       (s2)-[:BELONGS_TO_MERIDIAN]->(m1),
       (s3)-[:BELONGS_TO_MERIDIAN]->(m1),
       (s4)-[:BELONGS_TO_MERIDIAN]->(m1),
       (s5)-[:BELONGS_TO_MERIDIAN]->(m1),
       (s26)-[:BELONGS_TO_MERIDIAN]->(m2),
       (s27)-[:BELONGS_TO_MERIDIAN]->(m2),
       (s28)-[:BELONGS_TO_MERIDIAN]->(m2),
       (s8)-[:BELONGS_TO_MERIDIAN]->(m3),
       (s9)-[:BELONGS_TO_MERIDIAN]->(m3),
       (s10)-[:BELONGS_TO_MERIDIAN]->(m3),
       (s11)-[:BELONGS_TO_MERIDIAN]->(m3),
       (s12)-[:BELONGS_TO_MERIDIAN]->(m3),
       (s13)-[:BELONGS_TO_MERIDIAN]->(m4),
       (s14)-[:BELONGS_TO_MERIDIAN]->(m4),
       (s15)-[:BELONGS_TO_MERIDIAN]->(m4),
       (s16)-[:BELONGS_TO_MERIDIAN]->(m4),
       (s17)-[:BELONGS_TO_MERIDIAN]->(m5),
       (s18)-[:BELONGS_TO_MERIDIAN]->(m5),
       (s19)-[:BELONGS_TO_MERIDIAN]->(m5),
       (s20)-[:BELONGS_TO_MERIDIAN]->(m6),
       (s21)-[:BELONGS_TO_MERIDIAN]->(m6),
       (s22)-[:BELONGS_TO_MERIDIAN]->(m6);

// 验证数据导入
MATCH (s:Symptom) RETURN count(s) AS symptom_count;
MATCH (sy:Syndrome) RETURN count(sy) AS syndrome_count;
MATCH (f:Formula) RETURN count(f) AS formula_count;
MATCH (c:Classic) RETURN count(c) AS classic_count;
MATCH (m:Meridian) RETURN count(m) AS meridian_count;

// 查看症状-证型-方剂的完整链路
MATCH path = (s:Symptom)-[:INDICATES]->(sy:Syndrome)-[:HAS_FORMULA]->(f:Formula)
RETURN s.name, sy.name, f.name
LIMIT 10;