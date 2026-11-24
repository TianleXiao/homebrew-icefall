class Icefall < Formula
  desc "TLS record fragmentation proxy that bypasses SNI-based network blocking"
  homepage "https://github.com/TianleXiao/icefall"
  url "https://github.com/TianleXiao/icefall.git",
      tag:      "v1.0.0",
      revision: "fa240da51cf20d90689eb338789e267bfbc3699d"
  license "MIT"
  head "https://github.com/TianleXiao/icefall.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  def caveats
    <<~EOS
      启动代理：
        icefall proxy 127.0.0.1:8899

      首次运行先探测本机封锁情况（约 5 秒，生成 strategy.json）：
        icefall discover

      设为系统代理（PAC 自动分流）：
        icefall setproxy pac

      开机自启：
        brew services start icefall
    EOS
  end

  service do
    run [opt_bin/"icefall", "proxy", "127.0.0.1:8899"]
    keep_alive false
    log_path var/"log/icefall.log"
    error_log_path var/"log/icefall.err"
  end

  test do
    assert_predicate bin/"icefall", :exist?
    # pac 子命令生成 PAC 后退出 0，不阻塞，适合做冒烟测试
    assert_match "FindProxyForURL", shell_output("#{bin}/icefall pac 2>&1")
  end
end
