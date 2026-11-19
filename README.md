# Cursor Automotive Electronics Annotation Standards

面向汽车电子嵌入式 C 代码的 [Cursor Agent Skills](https://cursor.com/docs/skills)：写代码时按 AUTOSAR Classic 命名，并按 MISRA C:2012 改码；代码完成后再按统一注释规范补注释。适用于驱动、通信、Boot、应用等各层的 `.c` / `.h`。

现在作为通用的汽车电子注释标准使用。

全称：**AEAS**（Automotive Electronics Annotation Standards）。正式技能只有一个：`aeas`。调用 **`@aeas`** / **`/aeas`**（不区分大小写）。没有 `@` 或 `/` 的 `aeas` 不触发。

目录必须是小写 **`aeas/`**。

| 步骤 | 规则 |
|------|------|
| 第一步：先把代码写完或改完 | 公开函数用 `<Mip>_<ServiceName>`，如 `Adc_ReadTask`；宏、类型、全局变量按 AUTOSAR Classic 命名；按 MISRA C:2012 改码（大括号、`else` 收尾、`switch` 的 `default` 与 `break`、`0U`、`(void)` 使用返回值、控制表达式用布尔比较等） |
| 第二步：代码完成后再补注释 | 文件头、分区、`.h` 简写 / `.c` 完整函数块、复杂函数体内 `a.` / `1.` 步骤。顺序不能反。 |

同一天对同一文件的修订记录只保留一条，不要再额外写一行。

默认作者是 **YYH**，写在 [skills/aeas/AUTHOR](skills/aeas/AUTHOR)。把 `AUTHOR` 改成一行新名字后，在云端机器和本机各跑一次安装，会同步到：

- `%USERPROFILE%\.cursor\skills\aeas\AUTHOR`
- `%USERPROFILE%\.agents\skills\aeas\AUTHOR`

当次对话写 `作者 ZS` 只影响这一轮。只影响当前工程时，在工程根目录放 `.aeas-author`。对照见 [skills/aeas/examples.md](skills/aeas/examples.md)。

已有代码但原来没有注释时：修订记录第一行是 `V1.0  未知  未知  初始发布版本`，补注释的人只出现在下一行。

## 安装

本机 PowerShell（不要依赖 Cloud Agent 云端目录）：

```powershell
irm https://raw.githubusercontent.com/neo-yang-dev/Cursor-Automotive-Electronics-Annotation-Standards/main/scripts/install-from-github.ps1 | iex
```

或从仓库安装：

```powershell
git clone https://github.com/neo-yang-dev/Cursor-Automotive-Electronics-Annotation-Standards.git
cd Cursor-Automotive-Electronics-Annotation-Standards
git pull
.\scripts\install.ps1
```

`raw` 地址可能有几分钟缓存。刚合并后若下到旧文件，给地址加 `?t=` 和时间戳，或隔几分钟再试。

装完后：**完全退出 Cursor → 再开 → 新对话 → `@aeas` 或 `/aeas`**。

## 仓库结构

```
Cursor-Automotive-Electronics-Annotation-Standards/
├── README.md
├── LICENSE
├── skills/
│   └── aeas/
│       ├── SKILL.md
│       ├── examples.md
│       └── AUTHOR            # 默认 YYH，一行
└── scripts/
    ├── install.ps1
    ├── install.sh
    ├── install-from-github.ps1
    └── publish.ps1
```

## 常见问题

| 现象 | 处理 |
|------|------|
| `@aeas` 找不到 Skill | 用上方脚本装到 `%USERPROFILE%\.cursor\skills\aeas`，并完全退出 Cursor 后再开新对话 |
| 作者不是想要的名字 | 改 `skills/aeas/AUTHOR` 后云端和本机都重装，或当次说 `作者 ZS` |
| 旧文件初始版本作者变成补注释的人 | 初始行作者保持 `未知`，本次另记一行；若已是同一天，则合并进当天那一行 |
| 只补了注释，函数名或 MISRA 没改 | 必须先按 AUTOSAR 和 MISRA 改完代码，再补注释 |

## License

MIT — 见 [LICENSE](LICENSE)
