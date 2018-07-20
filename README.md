# Hombrew - burstcoind (burstcoin dameon)
Formula for installing the BRS (Burst Refrence Software) wallet on macOS.

---

### What is Homebrew?
Homebrew is a package manager for macOS similar to apt-get on Linux. It is useful for installing an ever widening array of software very quickly and simply. You can read more about Homebrew on their website, [brew.sh](https://brew.sh).

### Requirements
* Java 8
* Hombrew
* MariaDB (optional - default is H2)

### How to install 
Simply copy and past the follwoing commands into a Terminal window and press enter to run.

1. Install Homebrew, skip if you already have Homebrew installed on your machine.

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
```

2. Install Java 8, skip if you have already installed Java 8.

```
brew cask install homebrew/cask-versions/java8
```

3. Tap the burstcoin dameon.

```
brew tap nixops/homebrew-burstcoind
```

4. Install the burstcoin dameon.

```
brew install burstcoind
```

5. Start the wallet.

```
burstcoind
```

---

### Changing databases from H2 to MariaDB

1. Install MariaDB.

```
brew install mariadb
```

2. Start the MariaDB server.

```
brew service start mariadb
```

3. Open the MariaDB session.

```
mysql -uroot
```

4. Run the following commands one after the other...

```
CREATE DATABSE brs;
CREATE USER ‘admin’@‘localhost’ IDENTIFIED BY ‘password’;
GRANT ALL PRIVILEGES ON brs.* TO ‘admin’@‘localhost’ IDENTIFIED BY ‘password’;
ALTER DATABASE brs CHARACTER SET utf8mb4 COLLATE utf8mbr_unicode_ci;
EXIT
```

5. Open the `brs.properties` file.

```
sudo nano cd /usr/local/Cellar/burstcoind/2.2.1/bin/conf/brs.properties
```

6. Update the database configuration.

Replace...
>DB.Url=jdbc:h2:./burst_db/burst;DB_CLOSE_ON_EXIT=False     
>DB.Username=sa     
>DB.Password=sa     

with...
>DB.Url=jdbc:mariadb://localhost:3306/brs     
>DB.Username=admin     
>DB.Password=password     
    
7. Save and confirm the edited file.

`CTRL + X` --> `y` --> `ENTER`

8. Start the wallet.

```
burstcoind
```

---

### Issues

If you have any issues, please open an issue **within THIS repository**. 

In the issue, please include the following:
* Homebrew version `brew -v`
* Java Version `java --version`
* MacOS Version (Apple at top left --> About this Mac. The specific version is needed [eg. 10.13.6]).
