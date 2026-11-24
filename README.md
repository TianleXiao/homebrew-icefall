# homebrew-icefall

Homebrew tap for [碎冰 Icefall](https://github.com/TianleXiao/icefall) —— 用 TLS record 分片绕过校园网 SNI 封锁。

## 安装

```bash
brew tap TianleXiao/icefall
brew install icefall
```

## 使用

```bash
icefall discover              # 首次：探测本机封锁情况，生成 strategy.json
icefall setproxy pac          # 设为系统代理（PAC 自动分流）
brew services start icefall   # 开机自启（可选）
icefall unsetproxy            # 还原系统代理
```

详见 [主仓库 README](https://github.com/TianleXiao/icefall#readme)。

## 说明

从源码编译，需要 `go`（formula 会自动装构建依赖）。分片逻辑跨平台一致；
macOS 上想覆盖微信客户端、游戏启动器这类不读系统代理的程序，需要 NetworkExtension
（需 Apple Developer 账号），目前尚未提供。
