# dsh-test

DSH（DeepSeek Harness）测试代码仓库：存放由 DSH 编写、运行的验证与测试代码。

## 用途

- 验证 DSH 的工具链（文件、命令、Git、网络、模型）是否正常
- 存放临时或长期的测试脚本、冒烟测试、回归用例
- 语言不固定：按测试目标选择 Node/TypeScript、Python 或 PowerShell

## 目录约定

```
tests/
  <YYYY-MM-DD>-<主题>/
    README.md      目的、运行方法、预期结果
    ...            测试代码（语言不限）
```

一个测试一个目录，目录内自包含、可独立运行。

## 运行示例

在仓库根目录执行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tests\2026-11-13-smoke\test-smoke.ps1
```

（PowerShell 5.1 默认执行策略为 RemoteSigned，脚本需带 `-ExecutionPolicy Bypass` 运行；有 pwsh 7 时可直接 `pwsh -File ...`）

## 约定

- 代码里不写死本机绝对路径；必要配置从环境变量读取
- 不提交密钥、令牌、日志、`node_modules`、`.venv`
- 每个测试在 README 里写清「怎么跑、预期什么」
- 测试失败要能通过退出码体现，方便自动化

## 历史

- 2026-11-13：仓库创建，验证 SSH 认证、提交身份与推送
- 2026-11-13：加入测试目录约定与冒烟测试示例
