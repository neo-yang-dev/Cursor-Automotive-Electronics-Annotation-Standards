---
name: aeas
description: >-
  @aeas / /aeas (case-insensitive): Automotive Electronics Annotation
  Standards. Forced two steps, never reversed: (1) finish writing or fixing
  code first — AUTOSAR Classic naming plus MISRA C:2012; (2) only after the
  code is complete, add comments (file banner, section blocks, .h brief /
  .c full Service Name, mandatory a./1. in-body steps). Trigger on @aeas
  or /aeas. Bare aeas without @ or / does not trigger.
---

# AEAS — Automotive Electronics Annotation Standards

**短调用名（不区分大小写）**：`@aeas` / `/aeas`

> 目录名必须为小写 `aeas`。没有 `@` 或 `/` 的 `aeas` 不触发。

本技能默认同时套用：AUTOSAR Classic 命名、MISRA C:2012 改码、以及注释规范。没有「只加注释、不改函数名」的模式。

## 执行顺序（必须，不能反过来）

1. **先按代码风格把代码写完或改完**
   - 按下方 AUTOSAR Classic 规则处理公开函数、宏、类型和全局变量命名，并按 MISRA C:2012 改码
   - 这一步完成前，不要先写文件头、函数块或体内步骤注释
2. **代码完成后再按注释规范补注释**
   - 文件头、分区、`.h` 简写 / `.c` 完整 Service Name、复杂函数体内 `a.` / `1.` 步骤
   - Service Name 必须等于第一步已经确定的最终函数名
   - 若发现代码仍不合规，回到第一步改完，再回来补注释

**自检**：代码已符合命名与 MISRA；注释是在代码完成之后补上的；没有先注释后改码；同一天的修订记录没有拆成多行。

代码规则按 **MISRA C:2012** 的公开条款，以及 **AUTOSAR CP R4.4.0**《General Specification of Basic Software Modules》（`AUTOSAR_SWS_BSWGeneral`）中的命名与类型要求收紧。这不是完整符合性检查，也不能替代正式认证。不确定或因平台约束无法完全符合时，用 `/* MISRA 偏离：原因 */` 或 `/* AUTOSAR 偏离：原因 */` 标明，不要编造已符合。

默认作者是 **YYH**（与本文件同级的 [AUTHOR](AUTHOR)，内容一行 `YYH`）。文件缺失时仍用 `YYH`。

## 作者名

按顺序取，取到即停：

1. 本轮对话写明：`作者 ZS`、`author ZS`（只影响这一轮，不改文件）
2. 当前工程根目录 `.aeas-author`（仅一行名字；只影响这个工程）
3. 与本 `SKILL.md` 同级的 `AUTHOR`（默认 `YYH`）

用户当次明确说「作者留空」时，作者列留空。不要猜 git 用户名。

永久改名并让云端、本机一致：把新名字写入仓库 `skills/aeas/AUTHOR`，再跑安装脚本。脚本把同一份写到这两处（云端机器和本机各跑一次）：

- `~/.cursor/skills/aeas/AUTHOR`（Windows：`%USERPROFILE%\.cursor\skills\aeas\AUTHOR`）
- `~/.agents/skills/aeas/AUTHOR`（Windows：`%USERPROFILE%\.agents\skills\aeas\AUTHOR`）

三处内容必须相同。对照见 [examples.md](examples.md) 的「作者名示例」。

函数块 `Author` 与文件头「作    者」用同一名字，但受下一节「原先没有注释」约束。

## 修订记录

先看目标文件有没有本规范文件头。

| 情况 | 作    者 / 函数 Author | 修订记录 |
|------|------------------------|----------|
| 本轮新建的文件或函数 | 上面解析到的作者名（默认 `YYH`） | 一行：`V1.0  当天  该作者  初始发布版本` |
| 已有代码，但没有本规范文件头（后来才补注释） | `未知`。原始作者不可考，不要写成补注释的人 | 第一行作者为 `未知`：`V1.0  未知  未知  初始发布版本`。下一行才是本次：`V1.1  当天  调用方作者  补充注释` |
| 已有本规范文件头 | 保持原作者，不改名 | 见下方「同一天合并」 |

后补注释时：文件头「版    本」改为当前这条修订的版本号，「日    期」改为本次日期。原先没有可靠日期时，初始行的日期列写 `未知`，不要编造。

### 同一天的改动要合并

看修订记录的**最后一行**：

- 如果该行日期已经是今天，**不要再追加一行，也不要升高版本号**。把本次改动说明合并进这一行；若作者不同，作者列写成 `YYH, ZS` 这样并列。文件头「版    本」「日    期」保持该行已有值。
- 只有最后一行是更早的日期（或还没有本次记录）时，才追加新的一行并升高版本号。

同一天多次修改，只保留一条记录。示例见 [examples.md](examples.md) 的「同一天的修订记录」。

## 命名（AUTOSAR Classic）

依据 `AUTOSAR_SWS_BSWGeneral`（CP R4.4.0）。本模块已有前缀时沿用；没有则用文件名去掉扩展名。全大写缩写写成首字母大写、其余小写（`ADC` → `Adc`）。单词从蛇形或驼峰拆开。拆不开就保持原名，不要编。工程里已有同类名字时，与工程保持一致，不要并列一套新前缀。

### 公开函数（SWS_BSW_00101 / 00102，及 8.3.1 的 API 命名）

只约束**公开函数**（`.h` 里声明的，或 `.c` 里非 `static` 的对外接口）。`static` 不改名。

形式：模块实现前缀 + 一个下划线 + 服务名（每个单词首字母大写，单词之间不再加下划线），即 `<Mip>_<ServiceName>`。

| 原来 | 结果 |
|------|------|
| `adc_read_task` / `ADC_Read_Task` | `Adc_ReadTask` |
| `Can_Write` / `Com_DeInit` | 已符合，不改 |

改名时同时改：`.h` 原型、`.c` 定义、本轮改动范围内的调用、以及第二步注释里的 Service Name。Service Name 必须等于最终函数名。

只要触发了 `@aeas` / `/aeas`，在本轮处理的文件里，不合规的公开函数都要改成上述形式。不要只改注释而留下旧函数名。不要跑到未涉及的文件里顺手改名。

公开 API 的输入指针参数应加 `const`（对应 SWS_BSW_00186 的要求）。工程已经使用 `P2CONST` / `P2VAR` 等编译器抽象宏时沿用；没有则只加 `const`，不要为了形式强行引入这些宏。

### 宏、枚举常量和状态值（SWS_BSW_00124）

`#define`、枚举字面量和状态值用全大写：`<MIP>_<SN>`，单词之间用下划线，如 `ADC_SAMPLE_TIMEOUT_MS`、`EEP_UNINIT`。`E_OK` 与 `E_NOT_OK` 除外，不要改名。

新建或改写的错误值用 `<MIP>_E_<EN>`（SWS_BSW_00125），如 `ADC_E_PARAM_LENGTH`。工程已有同类错误宏时沿用。

### 模块自定义类型（SWS_BSW_00146）

本模块新定义的类型写成 `<Ma>_<Tn>Type`，如 `Eep_LengthType`、`Dio_SignalType`。不要用 `int`、`char`、`short`、`long` 等 C 原生类型（SWS_BSW_00120）；改用工程已有的 AUTOSAR 整数类型（`uint8`、`uint16`、`uint32`、`sint8` 等，通常来自 `Platform_Types.h` / `Std_Types.h`）。若工程统一使用 `stdint.h` 的 `uint8_t` 等，与工程保持一致，不要混用两套。

### 全局变量（SWS_BSW_00130）

本模块定义的全局变量写成 `<Mip>_<Vn>`，变量名部分用驼峰，如 `Nm_RingData`。只读全局数据加 `const`（SWS_BSW_00131）。文件内专用对象用 `static`，不要改成公开全局名。

示例见 [examples.md](examples.md) 的「公开函数命名」。

## 何时套用

- 用户说 `@aeas` 或 `/aeas`（大小写不限）
- 用户要求按本仓库的汽车电子代码风格写代码、改码或补注释
- 审查或整改汽车电子嵌入式 `.c` / `.h`（驱动、通信、Boot、应用等）

---

# 第一部分：注释规范

注释只在第一步的代码已经完成之后补。不要先写这一部分再回头改代码。

一律使用 `/* */`（含行尾），不要用 `//`。这是本注释规范的版式要求，不是 MISRA C:2012 条款。

## 语言与语气

- **文件头 / 功能描述 / 步骤注释 / 宏说明**：中文，技术准确、偏 AUTOSAR/驱动层表述
- **分区标题**：英文居中（Header Files、Static Variables 等）
- **Service Name**：与函数名一致，英文
- 避免口语

## 1. 文件头（每个 .c / .h 必须有）

新建文件（默认作者 `YYH`）：

```c
/*==============================================================================
* 文件名称 : Can.c
* 作    者 : YYH
* 版    本 : V1.0
* 日    期 : 2026-10-12
==============================================================================
* 功能描述 : 
* [一两句话说明本文件职责；可多行]
*
* 修订记录 :
* V1.0  2026-10-12  YYH  初始发布版本
==============================================================================*/
```

已有代码、原先没有注释，本次才补上（默认作者 `YYH`）：

```c
/*==============================================================================
* 文件名称 : Can.c
* 作    者 : 未知
* 版    本 : V1.1
* 日    期 : 2026-10-12
==============================================================================
* 功能描述 : 
* [一两句话说明本文件职责；可多行]
*
* 修订记录 :
* V1.0  未知        未知  初始发布版本
* V1.1  2026-10-12  YYH   补充文件头与函数注释
==============================================================================*/
```

同一天如果还要继续改，不要再写 `V1.2`，把说明合并进 `V1.1` 那一行。

## 2. 一级分区（英文标题居中）

常用：Header Files、Type Definitions、Data Structure Definitions、Macros Definition、
Static Variables、Local Functions、Global Variables、Global Function Prototypes、
External Declarations、Global Functions。

```c
/*==================================================================================================
                                        Header Files
==================================================================================================*/
```

## 3. 函数注释（.h 简写 / .c 完整）

| 位置 | 风格 | 字段 |
|------|------|------|
| `.h` | 简写 | Service Name、Description、Author |
| `.c` / static | 完整 | 另加 Arguments、Return Value |

`.h` 不写 Arguments / Return Value；无参 / `void` 在 `.c` 写 `None`。Service Name 与函数名一致。

## 4. 函数体内步骤注释（必填）

复杂 / 多阶段 / 多分支函数**禁止**只写块头：

- 顶层：`a.` `b.` `c.` …
- 子步骤：`1.` `2.` `3.` …
- 写阶段意图与失败后果，不复述函数名

完整示例见 [examples.md](examples.md) 中 `Boot1_Download_FinishStep`。

## 5. 结构体 / 宏 / 文件尾

- 成员：`/**< 中文说明 */`
- 宏 / 初始化表：行尾 `/* 中文说明 */`
- 文件尾：`/* [] END OF FILE */`

---

# 第二部分：代码风格（第一步完成）

先按本节把代码写完或改完，再进入第一部分补注释。保持功能等价，不臆造业务行为。

## A. MISRA C:2012

下列条款按规则编号执行。这里收录与改码最直接相关、且有公开表述的常用项，不是完整规则集。

| 编号 | 要求 | 不合格 | 合格 |
|------|------|--------|------|
| 15.6 | if/else/for/while/do/switch 的体必须是复合语句（加大括号） | `if (x) return;` | `if (x) { return; }` |
| 15.7 | `if … else if` 必须以 `else` 结束 | 只有 `if` / `else if`，没有收尾 `else` | 最后补 `else`（可处理剩余情况；若确定无需动作，写空 `else` 并加一行说明） |
| 16.4 | 每个 `switch` 必须有 `default` | 无 `default` | 有 `default:` 分支（可 Abort / 断言语义） |
| 16.3 | 每个 case 子句必须以无条件 `break` 结束 | case 落空到下一支 | 每个 case 都有 `break`。若算法必须贯通，保留贯通并写 `/* MISRA 16.3 偏离：原因 */` 与 `/* fall through */` |
| 17.7 | 有返回值的函数，返回值必须被使用 | 调用后既不判断也不丢弃 | 使用返回值，或 `(void)expr;` |
| 7.2 | 无符号整型常量加 `u` / `U` 后缀 | `0xFF` 当作 unsigned 用 | `0U`、`1U`、`0xFFU`；需要时用 `UL` / `ULL` |
| 14.4 | if / 循环的控制表达式应是本质上的布尔 | `if (ret)`、`while (ptr)` | `if (0U != ret)`、`if (NULL != ptr)`、`if (TRUE == bFlag)`（或项目既有布尔类型/宏） |
| 10.3 / 10.4 | 不要把表达式赋给更窄或不同本质类型的对象；参与常规算术转换的两侧本质类型类别应相同 | 有符号与无符号混比、窄化暗转 | 显式转换或先统一类型再比较、再赋值，并确认范围安全 |
| 11.9 | 整型空指针常量只用 `NULL` | `if (0 == ptr)`、`p = 0` | `if (NULL == ptr)`、`p = NULL` |
| 8.2 | 函数类型用带参数名的原型形式 | `void foo();`、`void bar(uint8)` | `void foo(void);`、`void bar(uint8 channel)` |
| 8.3 / 8.4 | 声明与定义的参数名、类型、`const` 资格一致；有外部链接的对象或函数，定义处应能看到兼容声明 | `.c` 里直接定义公开函数，头文件无原型 | 公开函数在 `.h` 声明，`.c` 定义与之一致 |

指针与整型互转、不同对象指针之间的转换，必须经工程规定的 typedef 或平台宏，禁止裸 cast 乱用（对照 11.1–11.3、11.6–11.8）。

函数式宏的参数和宏体要加括号，`#endif` 旁写对应标签（如 `#endif /* CAN_H */`）。文件内专用对象和函数加 `static`（8.8）。不要在头文件写函数体，除 `static inline` 且项目已允许。

错误路径保持原设计语义（例如 Flash 失败时仍要 `EndSession` + `Abort` + NRC）。不要为了消告警而改变对外行为或删掉错误处理。

## B. AEAS 附加约定（第一步同样强制）

这两项不是 MISRA C:2012 的条款，但是本技能的强制代码风格。

**比较式写成常量在左**（防止 `=` 误写成比较）：

| 不合格 | 合格 |
|--------|------|
| `if (pnrc != NULL)` | `if (NULL != pnrc)` |
| `if (ret != 0)`（unsigned） | `if (0U != ret)` |

**有含义的数字必须提成宏**。通道号、长度、下标、超时、掩码、阈值、协议常量、重试次数都换成带中文说明的 `<MIP>_<SN>` 宏（命名同时满足 SWS_BSW_00124）。每次 `@aeas` 都做，不需要用户另外提。

| 做法 | 说明 |
|------|------|
| 位置 | 多个文件用到放 `.h` 的 Macros Definition；只本文件用放该文件的宏分区 |
| 写法 | `#define ADC_SAMPLE_TIMEOUT_MS (10U) /* 单次转换超时 */` |
| 不包一层 | `0`、`0U`、`1`、`1U`、`NULL`、`TRUE`、`FALSE`，以及宏自己定义式里的那个数字 |
| 不另造 | 工程里已有同含义的宏或枚举时，沿用，不并列一个新名字 |

## 改码完成后的注释同步

- 第一步改完代码后，第二步再补齐或更新对应 `a.` / `1.` 步骤注释，使其与最终代码一致
- 不要为“显得改过”而写与行为无关的长注释
- 若因硬件或平台约束无法完全符合某条规则，在该处用一行偏离说明标明

## 改码对照示例（片段）

**不合格：**

```c
if (pnrc != NULL)
    *pnrc = DCM_NRC_OK;
if (ret) {
    return BOOT1_FINISH_FAIL;
}
Boot_FlagPara_ClearBootRequest(&s_stFinishMeta);
```

**合格（AEAS）：**

```c
/* a. 可选输出初始化：默认 NRC 为 OK */
if (NULL != pnrc)
{
    *pnrc = DCM_NRC_OK;
}
if (0U != ret)
{
    return BOOT1_FINISH_FAIL;
}
(void)Boot_FlagPara_ClearBootRequest(&s_stFinishMeta);
```

上面片段里的步骤注释属于第二步，应在代码改完后再补。完整范例见 [examples.md](examples.md)。

## 不要做的事

- 不要先写注释再改代码，也不要把两步合成一步后交差
- 不要用 `//`
- 不要复杂函数只写 Service Name、函数体零步骤注释
- 不要为消 MISRA 告警而改变对外语义或删除错误处理
- 不要在 `.h` 写 Arguments / Return Value
- 不要省略文件头与 END OF FILE
- 不要把后补注释的人写成「初始发布版本」的作者
- 不要在同一天为同一次文件改动再追加一条修订记录或升高版本号，应合并进当天已有的那一行
- 不要只改一处 `AUTHOR`：仓库、`~/.cursor/skills/aeas/AUTHOR`、`~/.agents/skills/aeas/AUTHOR` 要一致
- 不要留下不合规的公开函数名，也不要给 `static` 函数套公开命名，或写成 `Adc_Read_Task` 这种单词之间再加下划线的形式
- 不要在新改的代码里使用 `int` / `char` / `short` / `long` 等 C 原生类型
- 不要把 `0U`、`1U` 包成宏，也不要为同一个数再写一个同义宏
