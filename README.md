# homebrew-burstcoind
Homebrew package for burstcoin for macOS

Requirements:

Homebrew
Java8


How to Setup:

Follow instructions for homebrew here:

https://brew.sh

Homebrew is quite useful, not just for installing burst but lots of other missing packages from macOS.

Or execute the following in a terminal:
````
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
````
From there you will need to install Java8 

````
brew cask install homebrew/cask-versions/java8
````

Once you have Java8 installed you will need to run the below commands to complete installation.

````$xslt
Tap:
$ brew tap nixops/homebrew-burstcoind

Install:
$ brew install burstcoind

Start:
$ burstcoind 

````

If you have any issues please open an issue within this repository. In the issue include the following:

Homebrew version (brew -v)
Java Version (java --version)
MacOS Version (Apple at top left->About this Mac, will need specific version. e.g. 10.13.6 )