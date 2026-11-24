class Icefall < Formula
  desc "TLS-record fragmentation proxy that bypasses SNI-based blocking"
  homepage "https://github.com/TianleXiao/icefall"
  url "https://github.com/TianleXiao/icefall.git", tag: "v1.3.0", revision: "05fba98b0d37784cd535c223af085e5fda9984d7"
  version "1.3.0"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=v1.3.0"), "."
  end

  service do
    run [opt_bin/"icefall", "proxy", "127.0.0.1:8899"]
    keep_alive false
    log_path var/"log/icefall.log"
    error_log_path var/"log/icefall.err"
  end

  test do
    assert_match "FindProxyForURL", shell_output("#{bin}/icefall pac 2>&1")
    assert_match "v1.3.0", shell_output("#{bin}/icefall version 2>&1")
  end
end