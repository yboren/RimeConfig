# Rime 输入法配置（小狼毫 Weasel）

基于极点五笔86的 Rime 输入法配置，包含英文释义、符号快捷输入、微信风格主题等功能。

## 功能特性

- **五笔86极点方案** — 主输入方案，含简体/繁体/拼音混输
- **英文释义** — 候选词显示英文翻译（23万词条，来自青简输入法词库）
- **符号快捷输入** — 输入 `/` + 关键词快速输入特殊符号
- **符号分类查询** — 输入 `fhlb` 查看所有符号分类
- **微信风格主题** — 浅色绿色配色方案，方形圆角候选窗
- **中英状态图标** — 托盘显示"中"/"英"方块图标
- **翻页快捷键** — 支持 `[]` `-=` `Tab` 翻页
- **自动调频** — 用户词典记录词频，常用词自动前移
- **拼音反查** — 输入 `z` + 拼音 + `'` 反查五笔编码

## 文件说明

```
RimeConfig/
├── README.md                          # 本文件
├── rime.lua                           # Lua 入口（预加载释义表 + 符号帮助）
├── default.custom.yaml                # 默认配置（翻页键、选词键等）
├── weasel.custom.yaml                 # Weasel 外观配置（微信主题）
├── glossary_data.tsv                  # 英文释义数据（23万条）
├── icon_zh.ico                        # 中文模式图标（绿色"中"）
├── icon_en.ico                        # 英文模式图标（蓝色"英"）
├── wubi86_jidian.ico                  # 五笔方案图标
│
├── wubi86_jidian.schema.yaml          # 五笔86极点方案
├── wubi86_jidian_pinyin.schema.yaml   # 五笔+拼音混输方案
├── wubi86_jidian_trad.schema.yaml     # 五笔繁体方案
├── wubi86_jidian_trad_pinyin.schema.yaml # 五笔繁体+拼音混输
├── pinyin_simp.schema.yaml            # 简明拼音方案
├── numbers.schema.yaml                # 数字输入方案
│
├── wubi86_jidian.dict.yaml            # 五笔主词典
├── wubi86_jidian_extra.dict.yaml      # 扩展词条
├── wubi86_jidian_extra_district.dict.yaml # 地区词条
├── wubi86_jidian_user.dict.yaml       # 用户词条
├── wubi86_jidian_user_hamster.dict.yaml   # iOS用户词条
├── pinyin_simp.dict.yaml              # 拼音词典
│
├── lua/                               # Lua 脚本目录
│   ├── english_glossary_filter.lua    # 英文释义过滤器
│   ├── symbol_help_translator.lua     # 符号分类查询
│   ├── wubi86_jidian_date_translator.lua  # 日期时间翻译
│   ├── wubi86_jidian_single_char_first_filter.lua # 单字优先
│   └── wubi86_jidian_single_char_only.lua  # 纯单字模式
│
└── weasel-theme/                      # Weasel 主题备份
    └── weasel.custom.yaml
```

## 安装方法

### 前置条件

- 安装 [小狼毫（Weasel）](https://github.com/rime/home/releases) 0.17.4 或以上版本

### 步骤

1. **克隆仓库**
   ```bash
   git clone ssh://git@codehub-dg-g.huawei.com:2222/r00670017/RimeConfig.git
   ```

2. **复制配置到 Rime 用户目录**
   ```bash
   # Windows 用户目录通常为：%APPDATA%\Rime
   # 即 C:\Users\<用户名>\AppData\Roaming\Rime

   # 复制所有配置文件
   cp RimeConfig/* %APPDATA%\Rime\

   # 复制 Lua 脚本
   mkdir -p %APPDATA%\Rime\lua
   cp RimeConfig/lua/* %APPDATA%\Rime\lua\
   ```

3. **重新部署**
   - 右键托盘小狼毫图标 → 「重新部署」
   - 或删除 `%APPDATA%\Rime\build` 目录后重启 WeaselServer

4. **验证**
   - 打字测试候选词是否正常
   - 候选词旁应显示英文释义（如 `苹果 n. apple`）
   - 输入 `fhlb` 查看符号分类

## 使用指南

### 英文释义

打字时候选词旁自动显示英文翻译。释义数据来自青简输入法的 `glossary-en.qj` 词库（23万词条）。

- 数据文件：`glossary_data.tsv`
- 格式：`中文词\t词性\t英文释义\t新词标记`
- 过滤器加载时机：Rime 启动时预加载，不影响打字速度
- 优化：单字候选词跳过查表，仅对多字词显示释义

### 符号快捷输入

输入 `/` + 关键词，选择需要的符号：

| 输入 | 说明 | 示例 |
|------|------|------|
| `/szq` | 圆圈数字 | ⓪①②③④⑤ |
| `/szh` | 括号数字 | ⑴⑵⑶⑷⑸ |
| `/1`~`/10` | 数字各种形式 | ①➀❶Ⅰ一壹 |
| `/zmq` | 圈字母 | ⓐⒶⓑⒷ |
| `/xh` | 星号 | ★☆✦✧ |
| `/jt` | 箭头 | ↑↓←→↕ |
| `/sx` | 数学符号 | ±÷×∈∑√ |
| `/hb` | 货币 | ￥¥$€£ |
| `/xl` | 希腊字母 | αβγδε |
| `/jm` | 日文假名 | あいうえお |
| `/tg` | 天干 | 甲乙丙丁戊 |
| `/dz` | 地支 | 子丑寅卯辰 |
| `/pk` | 扑克 | ♠♥♣♦ |
| `/bg` | 八卦 | ☰☱☲☳ |

输入 `fhlb` 可查看完整分类列表。

### 翻页快捷键

| 按键 | 功能 |
|------|------|
| `[` / `]` | 上一页 / 下一页 |
| `-` / `=` | 上一页 / 下一页 |
| `Tab` / `Shift+Tab` | 下一页 / 上一页 |
| `;` | 选第2候选 |
| `'` | 选第3候选 |

### 拼音反查

输入 `z` + 拼音 + `'` 可以用拼音反查五笔编码：
- `zping'` → 查"平"的五笔编码
- `zguo'` → 查"国"的五笔编码

### 主题与外观

- **配色**：微信风格浅色（绿色高亮，白色背景）
- **字号**：候选词 14pt，编号/注释 11pt
- **圆角**：10px
- **横排**：候选词横向排列
- **内嵌编码**：编码显示在光标处
- **托盘图标**：中文模式显示绿色"中"，英文模式显示蓝色"英"

### Lua 模块说明

本配置依赖 Weasel 0.17.4 的 rime.dll 中内置的 Lua 插件。Lua 模块在**部署时自动加载**，无需额外注入。

**重要**：如果重启 WeaselServer 后 Lua 功能失效（候选词异常），请**重新部署**：
1. 右键托盘图标 → 「重新部署」
2. 或删除 `%APPDATA%\Rime\build` 目录（保留 `weasel.yaml`）后重启

## 词库来源

- **五笔词库**：极点五笔86（KyleBing 修改版）
- **英文释义**：青简输入法 `glossary-en.qj`（DeepSeek LLM 生成，23万词条）
- **拼音词库**：简明拼音方案

## 许可

仅供个人使用。
