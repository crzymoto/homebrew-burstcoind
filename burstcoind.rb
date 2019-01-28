require 'formula'

class Burstcoind < Formula
  desc "Burstcoin Wallet"
  homepage "https://burst-coin.org"
  url "https://github.com/burst-apps-team/burstcoin/releases/download/2.2.7/burstcoin-2.2.7.zip"
  sha256 "3fd84d68207d5bdcf429c9f43cbb450f84780a2b06abff55784262dff5a30bc5"

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
