# 冒烟测试：DSH 开发环境

## 目的

检查本机是否具备 DSH 写测试代码所需的基础环境，并确认仓库状态正常。

## 运行

先进入仓库根目录，再执行（PowerShell 执行策略默认 RemoteSigned，需带 `-ExecutionPolicy Bypass`）：

```powershell
cd C:\Users\57172\work\app-dev\projects\dsh-test
powershell -NoProfile -ExecutionPolicy Bypass -File tests\2026-11-13-smoke\test-smoke.ps1
```

## 预期结果

- 逐项输出 `PASS` / `WARN` / `FAIL`
- 最后输出 `SMOKE OK`，退出码 0
- 有 FAIL 项时退出码 1

## 检查项

| 项 | 说明 |
|---|---|
| powershell | 当前版本 |
| git | 版本、提交身份、当前分支、远端地址 |
| node | 是否存在及版本（可选，缺了只 WARN） |
| python | 是否存在及版本（可选，缺了只 WARN） |
| worktree | 是否有未提交变更（有则 WARN，不算失败） |

## 备注

- 脚本输出保持英文，避免 Windows PowerShell 5.1 下中文编码乱码
- 新增测试脚本请沿用同样的「PASS/FAIL + 退出码」约定
