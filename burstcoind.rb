require 'formula'

class Burstcoind < Formula
  desc "Burstcoin Wallet"
  homepage "https://burst-coin.org"
  url "https://github.com/PoC-Consortium/burstcoin/releases/download/2.2.3/burstcoin-2.2.3.zip"
  sha256 "2657a6e607d4322e43d502df6b4b733166d12b333e93b3d4228a71a1c81eb69b"

  bottle :unneeded

  depends_on :java => "1.8"

  def install
    system "cp", "-rp", "conf/brs-default.properties", "conf/brs.properties"
    inreplace "conf/brs.properties", "DB.Url=jdbc:mariadb://localhost:3306/burstwallet", "DB.Url=jdbc:h2:./burst_db/burst;DB_CLOSE_ON_EXIT=False"
    inreplace "conf/brs.properties", "DB.Username=", "DB.Username=sa"
    inreplace "conf/brs.properties", "DB.Password=", "DB.Password=sa"
    bin.install Dir["conf"]
    bin.install Dir["burst.jar"]
    bin.install Dir["burst.sh"]
    bin.install Dir["html"]
    bin.install Dir["lib"]
    (bin/"burstcoind").write <<~EOS
                  #!/bin/bash
                  export JAVA_HOME=$(#{Language::Java.java_home_cmd("1.8")})
                  cd #{prefix}/bin
                  java -cp #{prefix}/bin/burst.jar:conf brs.Burst "$@"
                EOS
                chmod 0555, bin/"burstcoind"
   end
  test do
    system "#{prefix}bin/burst.sh" "--help"
  end
end
