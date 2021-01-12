#!/bin/bash
sudo apt -y update
sudo apt -y upgrade

sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y jq
sudo apt-get install -y ruby-full
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y libldns-dev
sudo apt-get install -y python-dnspython
sudo apt-get install -y git
sudo apt-get install -y rename
sudo apt-get install -y xargs
sudo apt-get install -y nmap
sudo apt install -y snapd
sudo apt install -y masscan

echo "Installing pip"
wget https://bootstrap.pypa.io/get-pip.py 
sudo python3 get-pip.py                          # use pip3 as pip3 
sudo python2 get-pip.py                          # use pip2 as pip / pip2
rm get-pip.py

#create a tools folder in ~/
mkdir ~/tools
cd ~/tools/

#install go
if [[ -z "$GOPATH" ]];then
echo "It looks like go is not installed, would you like to install it now"
PS3="Please select an option : "
choices=("yes" "no")
select choice in "${choices[@]}"; do
        case $choice in
                yes)

					echo "Installing Golang"
					wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz
					sudo tar -xvf go1.13.4.linux-amd64.tar.gz
					sudo mv go /usr/local
					export GOROOT=/usr/local/go
					export GOPATH=$HOME/go
					export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
					echo 'export GOROOT=/usr/local/go' >> ~/.bash_profile
					echo 'export GOPATH=$HOME/go'	>> ~/.bash_profile			
					echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bash_profile	
					source ~/.bash_profile
					sleep 1
                                        rm go*linux*.tar.gz
					break
					;;
				no)
					echo "Please install go and rerun this script"
					echo "Aborting installation..."
					exit 1
					;;
	esac	
done
fi

#install aquatone
echo "Installing Aquatone"
go get github.com/michenriksen/aquatone
echo "done"

#install chromium
echo "Installing Chromium"
sudo snap install chromium
echo "done"

echo "installing Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
pip install -r requirements.txt
cd ~/tools/
echo "done"

echo "installing dirsearch"
git clone https://github.com/maurosoria/dirsearch.git
cd ~/tools/
echo "done"

echo "installing dirsearch"
go get github.com/ffuf/ffuf
echo "done"

echo "installing massdns"
git clone https://github.com/blechschmidt/massdns.git
cd ~/tools/massdns
make
mv ./bin/massdns /usr/bin/massdns
cd ~/tools/
mkdir nameservers
cd nameservers
wget https://public-dns.info/nameservers.txt
cd ~/tools/
echo "done"

echo "installing httprobe"
go get -u github.com/tomnomnom/httprobe 
echo "done"

echo "installing waybackurls"
go get github.com/tomnomnom/waybackurls
echo "done"

echo "downloading Seclists"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo "done"

echo "installing censys"
git clone https://github.com/christophetd/censys-subdomain-finder.git  
cd censys-subdomain-finder  
pip3 install -r requirements.txt
cd ~/tools/

echo "installing subfinder (Don't forget to set API keys in ~/.config/subfinder/config.yaml!"
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder

echo "installing amass"
sudo snap install amass
if [[ ! -d ~/.config/amass ]];then
cd ~/.config
mkdir amass
cd amass
wget https://raw.githubusercontent.com/OWASP/Amass/master/examples/config.ini
cd ~/tools
fi
 
echo "installing bash_profile aliases" 
git clone https://github.com/Ermerins/recon_aliases.git
cd recon_aliases
echo " " >> ~/.bash_profile
cat .bash_profile >> ~/.bash_profile 
source ~/.bash_profile 
cd ~/tools/ 
rm -rf recon_aliases
echo "done"

echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in ~/tools"
