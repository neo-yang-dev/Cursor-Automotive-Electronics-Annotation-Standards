# 请先看：这一版改了什么

这是给仓库 https://github.com/neo-yang-dev/Cursor-Automotive-Electronics-Annotation-Standards 用的待推送文件包。我没有往 GitHub 推。请先审，没问题再自己提交并推送。

用本包里的 `aeas-skill/` 覆盖你本地仓库的对应文件后，再由你自己 `git add` / `commit` / `push`。

## 按你这次的意见做了这些

1. 保留「注释版式最早来自 PK2C / Traveo II 诊断栈（DiagStack）」这句说明。
2. 文档里不再写旧技能名称，也不再单独说明「还在用旧名称该怎么办」。安装脚本仍会静默清理本机遗留目录，但 README 和技能正文不再列出那些名字。
3. README 和技能正文做了精简：去掉重复说明，安装改为以一键脚本和仓库安装为主。
4. 同一天对同一文件的改动不再追加修订记录、也不升高版本号，把说明合并进当天已有的那一行；作者不同则写在同一格里。见 `skills/aeas/SKILL.md` 的「同一天的改动要合并」，以及 `examples.md` 的示例。
5. 对照了 MISRA C:2012 的公开条款，以及 AUTOSAR CP R4.4.0 `AUTOSAR_SWS_BSWGeneral` 的命名要求，能收紧的地方已收紧，并写明来源：
   - AUTOSAR：公开函数 `<Mip>_<ServiceName>`，宏/枚举 `<MIP>_<SN>`，错误值 `<MIP>_E_<EN>`，类型 `<Ma>_<Tn>Type`，全局变量 `<Mip>_<Vn>`；不用 `int` / `char` / `short` / `long`；公开 API 的输入指针加 `const`。
   - MISRA：补上 15.7（`else` 收尾）、14.4（控制表达式用布尔比较）、11.9（空指针只用 `NULL`）、8.2 / 8.4（带参数名的原型，定义处看得到声明）等；并为现有项补了规则编号。
   - 禁止 `//`、常量在左的比较式、魔法数字提宏，改标为 AEAS 强制约定，不再写成 MISRA 条款。
   - 明确：这不是完整符合性检查，也不能替代正式认证。

请重点看 `skills/aeas/SKILL.md` 和 `skills/aeas/examples.md`。安装脚本里的 raw 地址要等你推到仓库对应分支后才会生效。
