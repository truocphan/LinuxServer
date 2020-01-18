#!/bin/sh
echo "[+] Update and upgrade system..."
sudo apt update && sudo apt upgrade -y


echo "[+] Installing ..."
sudo apt install -y openssh-server openvpn git curl wget


echo "[+] Setup rc.local..."
sudo touch /etc/rc.local
sudo chmod 777 /etc/rc.local
sudo cat > /etc/rc.local << EOL
#!/bin/sh -e
IP=\$(ip -4 route get 8.8.8.8 | awk {'print \$7'}| tr -d '\n')
Interface=\$(ip -4 route get 8.8.8.8 | awk {'print \$5'}| tr -d '\n')
Gateway=\$(ip -4 route get 8.8.8.8 | awk {'print \$3'}| tr -d '\n')
echo "\$(tput setaf 3)\\
\$(hostnamectl)\n\n\\
----------------------------------------------------\n\\
        IP Address: \$IP\n\\
        Gateway IP: \$Gateway\n\\
         Interface: \$Interface\n\\
          Username: truocphan\n\\
          Password: TruocPhan\n\\
----------------------------------------------------\n\n\\
          Facebook: https://facebook.com/292706121240740\n\\
            E-mail: truocphan112017@gmail.com\n\\
            GitHub: https://github.com/truocphan\n\n\\
\$(tput sgr0)" > /etc/issue
exit 0
EOL


echo "[+] Changing Hostname..."
sudo hostnamectl set-hostname TruocPhan-Server



echo "[+] Setup banner ssh before login..."
sudo touch /etc/issue.net
sudo chmod 777 /etc/issue.net
sudo cat > /etc/issue.net << EOL
 _____                   ___ _
|_   _| _ _  _ ___  __  | _ \ |_  __ _ _ _
  | || '_| || / _ \/ _| |  _/ ' \/ _' | ' \\
  |_||_|  \_,_\___/\__| |_| |_||_\__,_|_||_|
         ___
        / __| ___ _ ___ _____ _ _
        \__ \/ -_) '_\ V / -_) '_|
        |___/\___|_|  \_/\___|_|

EOL
sudo sed -i 's/#Banner none/Banner \/etc\/issue.net/g' /etc/ssh/sshd_config


echo "[+] Installing zsh for root and current user..."
sudo apt install -y zsh powerline fonts-powerline
ls -a ~/ | grep -o .oh-my-zsh > /dev/null &&  rm -rf ~/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
sudo cp -r ~/.oh-my-zsh /root/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
sudo cp ~/.zshrc /root/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' ~/.zshrc
sudo sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' /root/.zshrc
chsh -s $(which zsh)
sudo chsh -s $(which zsh)


echo "[+] Installing nmap, sqlmap, smbmap..."
sudo apt install -y nmap sqlmap smbmap


echo "[+] Installing Apache, MySQL, PHP..."
sudo apt install -y apache2 mysql-server php


echo "[+] Installing metasploit..."
which msfconsole | grep -o msfconsole > /dev/null &&  echo "Metasploit is installed!" || (curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall && rm msfinstall)


echo "[+] Installing searchsploit..."
which searchsploit | grep -o searchsploit > /dev/null && echo "Searchsploit is installed!" || (sudo git clone https://github.com/offensive-security/exploitdb.git /opt/exploit-database && sudo ln -sf /opt/exploit-database/searchsploit /usr/local/bin/searchsploit && sudo cp -n /opt/exploit-database/.searchsploit_rc ~/ && sed -i -z 's/export PATH=.*\/usr\/local\/bin\/searchsploit.*\n//g' ~/.bash_profile && echo 'export PATH=/usr/local/bin/searchsploit:$PATH' >> ~/.bash_profile && source ~/.bash_profile)


echo "[+] Installing Golang..."
wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz
tar -xvf go1.13.4.linux-amd64.tar.gz
sudo rm -rf /usr/local/go 
sudo mv go /usr/local
sed -i -z 's/export GOROOT=.*\nexport GOPATH=.*\nexport PATH=.*\n//g' ~/.bash_profile
echo "export GOROOT=/usr/local/go" >> ~/.bash_profile
echo "export GOPATH=$HOME/go" >> ~/.bash_profile
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> ~/.bash_profile
source ~/.bash_profile
rm go1.13.4.linux-amd64.tar.gz


echo "[+] Installing ffuf..."
go get github.com/ffuf/ffuf
