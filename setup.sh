#!/bin/bash

tmd_dir=/tmp/dis

#define variables
install='apt install'
update='apt update; apt update -y'
user=$USER
#User=$(getent passwd 1000 | awk -F: '{ print $1}')

## Start script
cp /etc/apt/sources.list /etc/apt/sources.list.original

if [[ $EUID -ne 0 ]]; then
        echo "This script requires root access, try: sudo ./install.sh"
        exit 1
else
        #Update and upgrade
        echo "Updating and upgrading..."
        $update

        echo #Creating temportary folder
        mkdir $tmp_dir

        $install dialog
        cmd=(dialog --title "Tool-Installer" --separate-output --checklist "Please Select Software You Want To Install:" 22 80 16)
        options=(
        #A "<---Category: Repositories--->" on
            1_repos "   Contrib and Non-free repos" on
            2_repos "   Add Kali-Linux repos" on
	    3_repos "	Grant Standard User Root Access" off
        #B "<---Category: Information Gathering--->" on
            1_terminal  "   arp-scan" off
            2_terminal  "   DMitry" off
            3_terminal  "   DNSRecon" off
            #4_terminal "    EyeWitness" off
            5_terminal  "   H8mail" off
            6_terminal  "   Maltego" on
            7_terminal  "   Masscan" off
            8_terminal  "   Nikto" on
            9_terminal  "   Nmap" on
            10_terminal "   p0f" off
            11_terminal "   Recon-ng" on
            12_terminal "   SET" off
            13_terminal "   SMBMap" off
            14_terminal "   sslstrip" off
            15_terminal "   Sublist3r" off
            16_terminal "   theHarvester" off
            17_terminal "   Wireshark" on
        #C "<---Category: Vulnerability Analysis --->" on
            18_terminal "   openvas" off
            19_terminal "   sqlmap" on
        #D "<---Category: Exploitation Tools--->" on
            21_terminal "   Backdoor-Factory" off
            22_terminal "   BeEF" off
            23_terminal "   Exploit-DB" off 
            24_terminal "   Metasploit-Framework" off
            25_terminal "   Router-Sploit" off
            26_terminal "   Shellnoob" off
        #E "<---Category: Wireless Tools--->" on
            27_terminal "   Blueranger" off
            #28_terminal "   Bluesnarfer" off
            #29_terminal "   Bully" off
            30_terminal "   coWPAtty" off
            #31_terminal "   GISKismet" off
            32_terminal "   Kismet" on
            33_terminal "   PixieWPS" on
            34_terminal "   Pyrit" off
            35_terminal "   Reaver" off
            #36_terminal "   Redfang" off
            #37_terminal "   Wifite" on
        #F "<---Category: Forencics Tools--->" on
            38_terminal "   Binwalk" on
           #39_terminal "   Dumpzilla" off
            40_terminal "   Exiftool" on
        #G "<---Category: Web Tools--->" on
            #41_terminal "   Burp Suite" off
            42_terminal "   DIRB" on
            #43_terminal "   DirBuster" off
            44_terminal "   Gobuster" off
            #45_terminal "   joomscan" off
            #46_terminal "   Uniscan" off
            47_terminal "   WebSploit" off
            48_terminal "   Wfuzz" on
            49_terminal "   WhatWeb" off
            #50_terminal "   WPScan" on
            #51_terminal "   Zaproxy" on
        #H "<---Category: Stress Testing--->" on
            52_terminal "   mdk3" off
            53_terminal "   Reaver" off
        #I "<---Category: Sniffing and Spoofing--->" on
            #54_terminal "   bettercap" on
            #55_terminal "   HexInject" off
            56_terminal "   mitmproxy" off
            57_terminal "   responder" off
        #J "<---Category: Password Attacks--->" on
            58_terminal "   crunch" off
            #59_terminal "   FindMyHash" off
            #60_terminal "   gpp-decrypt" off
            #61_terminal "   hash-identifier" off
            62_terminal "   Hashcat" on
            63_terminal "   THC-Hydra" on
            64_terminal "   John the Ripper" on
            65_terminal "   Ncrack" off
            66_terminal "   ophcrack" off
            67_terminal "   patator" off
        #K "<---Category: Maintaining Access--->" on
            68_terminal "   dns2tcp" off
            69_terminal "   HTTPTunnel" off
            #70_terminal "   pwnat" off
            #71_terminal "   shellter" off
            #72_terminal "   Winexe" off
        #L "<---Category: Reverse Engineering--->" on
            73_terminal "   apktool" off
            74_terminal "   ADB" off
            75_terminal "   fastboot" off
        #M "<---Category: System--->" on
            V "Post Install Auto Clean Up % Update" on)
        choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
			case $choice in

# Section A -----------------------Repositories----------------------------
        1_repos)
            #Enable Contrib and Non-free Repos
			echo "Enabling Contrib and Non-free Repos"
			cat /etc/apt/sources.list >> /etc/apt/sources.list.bak
			sed -e '/Binary/s/^/#/g' -i /etc/apt/sources.list
			sed -i 's/main/main contrib non-free/gI' /etc/apt/sources.list
			apt update
			sleep 1
			;;

        2_repos)
            #Add Kali-Linux repos
            echo "Adding Kali-Linux Repositories"
            echo "deb http://http.kali.org/kali kali-rolling non-free contrib" > /etc/apt/sources.list.d/kali.list
            echo "Getting Kali archive key and adding it into keyring"
            wget https://archive.kali.org/archive-key.asc
            apt-key add archive-key.asc
            apt update
            sleep 1
            ;;

	3_repos)
	    #Grant root access to standard user
	    User=$getent password 1000 |  awk -F: '{ print $1}')
	    echo "$User ALL=(ALL:ALL)  ALL" >> /etc/sudoers
	    sleep 1
	    ;;

# Section B -----------------------TOOLS----------------------------
        1_terminal)
            #Install arp-scan
            echo "Installing arp-scan"
            sudo apt install arp-scan -yy
            sleep 1
            ;;

        2_terminal)
            #Install DMitry
            echo "Installing DMitry"
            sudo apt install dmitry -yy
            sleep 1
            ;;

        3_terminal)
            #Install DNSRecon
            echo "Installing DNSRecon"
            sudo apt install dnsrecon -yy
            sleep 1
            ;;

        4_terminal)
            #Install EyeWitness
            echo "Installing EyeWitness"
            sudo apt install python3-pip
            pip3 install eyewitness
            sleep 1
            ;;
        
        5_terminal)
            #Install H8mail
            echo "Installing H8mail"
            sudo apt install python3-pip
            pip3 install h8mail
            sudo mv /home/$User/.local/bin/h8mail /usr/bin
            sleep 1
            ;;
        
        6_terminal)
            #Install Maltgo
            echo "Installing Maltego"
            sudo apt install maltego -yy
            sleep 1
            ;;

        7_terminal)
            #Install Masscan
            echo "Installing Masscan"
            sudo apt install masscan -yy
            sleep 1
            ;;

        8_terminal)
            #Install Ńikto
            echo "Installing Nikto"
            sudo apt install nikto -yy
            sleep 1
            ;;
        
        9_terminal)
            #Install Nmap
            echo "Installing Nmap"
            sudo apt install nmap -yy
            sleep 1
            ;;
        
        10_terminal)
            #Install p0f
            echo "Installing p0f"
            sudo apt install p0f -yy
            sleep 1
            ;;

        11_terminal)
            #Install Recon-ng
            echo "Installing Recon-ng"
            sudo apt install recon-ng -yy
            sleep 1
            ;;

        12_terminal)
            #Install SET
            echo "Installing SET"
            git clone https://github.com/trustedsec/social-engineer-toolkit/ setoolkit/
            cd setoolkit
            pip3 install -r requirements.txt
            sudo python setup.py
            cd ..
            sleep 1
            ;;

        13_terminal)
            #Install SMBMap
            echo "Installing SMBMap"
            sudo apt install smbmap -yy
            sleep 1
            ;;

        14_terminal)
            #Install sslstrip
            echo "Installing sslstrip"
            sudo apt install sslstrip -yy
            sleep 1
            ;;

        15_terminal)
            #Install Sublist3r
            echo "Installing Sublist3r"
            git clone https://github.com/aboul3la/Sublist3r.git
            cd Sublist3r
            sudo pip install -r requirements.txt
            cd ..
            sleep 1
            ;;

        16_terminal)
            #Install theharvester
            echo "Installing TheHarvester"
            https://github.com/laramies/theHarvester.git
            cd theHarvester
            python3 -m pip install -r requirements/base.txt
            sudo cp theHarvester.py /usr/bin/theharvester
            sleep 1
            ;;

        17_terminal)
            #Install Wireshark
            echo "Installing Wireshark"
            sudo apt install Wireshark -yy
            sleep 1
            ;;

        
        18_terminal)
            #Install openvas
            echo "Installing openvas"
            sudo apt install openvas -yy
            sleep 1
            ;;
        
        19_terminal)
            #Install sqlmap
            echo "Installing sqlmap"
            sudo apt install sqlmap -yy
            sleep 1
            ;;
        
        20_terminal)
            #Install Armitage
            echo "Installing Armitage"
            sudo apt install armitage -yy
            sleep 1
            ;;

        21_terminal)
            #Install Backdoor-Factory
            echo "Installing Backdoor-Factory"
            sudo apt install backdoor-factory -yy
            sleep 1
            ;;

        22_terminal)
            #Install BeEf
            echo "Installing BeEF"
            sudo apt install beef -yy
            sleep 1
            ;;

        23_terminal)
            #Install Exploit-DB
            echo "Installing Exploit-DB"
            sudo git clone https://github.com/offensive-security/exploitdb.git /opt/exploitdb
            sudo ln -sf /opt/exploitdb/searchsploit /usr/local/bin/searchsploit
            sleep 1
            ;;

        24_terminal)
            #Install Metasploit-Framework
            echo "Installing postgresql"
            sudo apt install postgresql
            echo "Installing Metasploit-Framework"
            cd /tmp
            curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
            chmod +x msfinstall
            sudo ./msfinstall
            cd ..
            sleep 1
            ;;
        
        25_terminal)
            #Install Router-Sploit
            echo "Installing Router-Sploit"
            sudo apt install python3-pip -yy
            git clone https://www.github.com/threat9/routersploit /opt/routersploit
            cd /opt/routersploit
            python3 -m pip install -r requirements.txt
            sudo ln -sf /opt/routersploit/rsf.py /usr/local/bin/routersploit
            sleep 1
            ;;

        26_terminal)
            #Install Shellnoob
            echo "Installing Shellnoob"
            cd /tmp
            git clone https://github.com/reyammer/shellnoob.git
            cd shellnoob/
            sudo python shellnoob.py --install
            xdotool key Return
            cd ..
            sleep 1
            ;;
        
        27_terminal)
            #Install BluerRanger
            echo "Installing BlueRanger"
            sudo apt install -yy
            sleep 1
            ;;
        
        28_terminal)
            #Install Bluersnarfer
            echo "Installing Bluesnafer"
            git clone https://gitlab.com/kalilinux/packages/blueranger/-/blob/kali/master/blueranger.sh /opt/blueranger/blueranger.sh
            sudo ln -sf /opt/blueranger/blueranger.sh /usr/local/bin/blueranger
            sleep 1
            ;;
    
        29_terminal)
            #Install Bully
            echo "Installing Bully"
            sudo apt install -yy
            sleep 1
            ;;

        30_terminal)
            #Install cowpatty
            echo "Installing coWPAtty"
            sudo apt install cowpatty -yy
            sleep 1
            ;;
        
        31_terminal)
            #Install GISKismet
            echo "Installing GISkismet"
            sudo apt install -yy
            sleep 1
            ;;

        32_terminal)
            #Install Kismet
            echo "Installing Kismet"
            sudo apt install kismet -yy
            sleep 1
            ;;

        33_terminal)
            #Install PixieWPS
            echo "Installing PixieWPS"
            sudo apt install pixiewps -yy
            sleep 1
            ;;

        34_terminal)
            #Install pyrit
            echo "Installing Pyrit"
            sudo apt install pyrit -yy
            sleep 1
            ;;

        35_terminal)
            #Install reaver
            echo "Installing Reaver"
            sudo apt install reaver -yy
            sleep 1
            ;;

        36_terminal)
            #Install redfang
            echo "Installing redfang"
            sudo apt install redfang -yy
            sleep 1
            ;;

        37_terminal)
            #Install Wifite
            echo "Installing Wifite"
            sudo apt install wifite -yy
            sleep 1
            ;;

        38_terminal)
            #Install Binwalk
            echo "Installing Binwalk"
            sudo apt install binwalk -yy
            sleep 1
            ;;

        39_terminal)
            #Install Dumpzilla
            echo "Installing Dumpzilla"
            sudo apt install dumpzilla -yy
            sleep 1
            ;;

        40_terminal)
            #Install exiftool
            echo "Installing Exiftool"
            sudo apt install exiftool -yy
            sleep 1
            ;;

        41_terminal)
            #Install Burp Suite
            echo "Installing Burp-Suite" 
            sudo apt install burp -yy
            sleep 1
            ;;

        42_terminal)
            #Install DIRB
            echo "Installing DIRB" 
            sudo apt install dirb -yy
            sleep 1
            ;;

        43_terminal)
            #Install Dirbuster
            echo "Installing Dirbuster" 
            sudo apt install burp -yy
            sleep 1
            ;;

        44_terminal)
            #Install gobuster
            echo "Installing GoBuster" 
            sudo apt install gobuster -yy
            sleep 1
            ;;        

        45_terminal)
            #Install Joomscan
            echo "Installing Joomscan" 
            sudo apt install joomscan -yy
            sleep 1
            ;;


        46_terminal)
            #Install Uniscan
            echo "Installing Uniscan" 
            sudo apt install Uniscan -yy
            sleep 1
            ;;
            
        47_terminal)
            #Install websploit
            echo "Installing Websploit" 
            sudo apt install websploit -yy
            sleep 1
            ;;
        48_terminal)
            #Install Wfuzz
            echo "Installing Wfuzz" 
            sudo apt install wfuzz -yy
            sleep 1
            ;;
        49_terminal)
            #Install WhatWeb
            echo "Installing WhatWeb" 
            sudo apt install whatweb -yy
            sleep 1
            ;;

        50_terminal)
            #Install WPScan
            echo "Installing WPScan" 
            sudo apt install wpscan -yy
            sleep 1
            ;;

        51_terminal)
            #Install Zaproxy
            echo "Installing Zaproxy" 
            sudo apt install zaproxy -yy
            sleep 1
            ;;

        52_terminal)
            #Install mdk3
            echo "Installing mdk3" 
            sudo apt install mdk3 -yy
            sleep 1
            ;;

        53_terminal)
            #Install reaver
            echo "Installing Reaver" 
            sudo apt install reaver -yy
            sleep 1
            ;;

        54_terminal)
            #Install Bettercap
            echo "Installing Bettercap" 
            sudo apt install bettercap -yy
            sleep 1
            ;;
        
        55_terminal)
            #Install hexinject
            echo "Installing HexInject" 
            sudo apt install hexinject -yy
            sleep 1
            ;;

        56_terminal)
            #Install mitmproxy
            echo "Installing MITMproxy" 
            sudo apt install mitmproxy -yy
            sleep 1
            ;;

        57_terminal)
            #Install responder
            echo "Installing responder"
            pip3 install responder
            sudo mv /home/$User/.local/responder /usr/bin
            sleep 1
            ;;
        
        58_terminal)
            #Install crunch
            echo "Installing Crunch" 
            sudo apt install crunch -yy
            sleep 1
            ;;

        59_terminal)
            #Install findmyhash
            echo "Installing FindMyHash" 
            sudo apt install findmyhash -yy
            sleep 1
            ;;
        
        60_terminal)
            #Install gpp-decrypt
            echo "Installing gpp-decrypt" 
            sudo apt install gpp-decrypt -yy
            sleep 1
            ;;
        
        61_terminal)
            #Install hash-identifier
            echo "Installing hash-identifier" 
            sudo apt install hash-identifier -yy
            sleep 1
            ;;

        62_terminal)
            #Install hashcat
            echo "Installing Hashcat" 
            sudo apt install hashcat -yy
            sleep 1
            ;;

        63_terminal)
            #Install THC-hydrsudo apt install -yya
            echo "Installing THC-hydra" 
            sudo apt install hydra -yy
            sleep 1
            ;;
        
        64_terminal)
            #Install john the ripper
            echo "Installing John The Ripper" 
            sudo apt install john -yy
            sleep 1
            ;;
        
        65_terminal)
            #Install Ncrack
            echo "Installing Ncrack" 
            sudo apt install ncrack -yy
            sleep 1
            ;;

        66_terminal)
            #Install ophcrack
            echo "Installing ophcrack" 
            sudo apt install ophcrack -yy
            sleep 1
            ;; 

        67_terminal)
            #Install patator
            echo "Installing patator" 
            sudo apt install patator -yy
            sleep 1
            ;;

        68_terminal)
            #Install dns2tcp
            echo "Installing dns2tcp" 
            sudo apt install dns2tcp -yy
            sleep 1
            ;;

        69_terminal)
            #Install HTTPTunnel
            echo "Installing HTTPTunnel" 
            sudo apt install httptunnel -yy
            sleep 1
            ;;

        70_terminal)
            #Install pwnat
            echo "Installing pwnat" 
            sudo apt install pwnat -yy
            sleep 1
            ;;

        71_terminal)
            #Install shellter
            echo "Installing shellter" 
            sudo apt install shellter -yy
            sleep 1
            ;;

        72_terminal)
            #Install winexe
            echo "Installing Winexe" 
            sudo apt install winexe -yy
            sleep 1
            ;;

        73_terminal)
            #Install apktool
            echo "Installing apktool" 
            sudo apt install apktool -yy
            sleep 1
            ;;

        74_terminal)
            #Install adb
            echo "Installing adb" 
            sudo apt install adb -yy
            sleep 1
            ;;

        75_terminal)
            #Install fastboot
            echo "Installing fastboot" 
            sudo apt install fastboot -yy
            sleep 1
            ;;

		V)
			#Cleanup
			echo "Cleaning up"
			sudo apt update -yy
			sudo apt upgrade -yy
			sudo apt autoremove -yy
			rm -rf $tmp_dir
			;;
		esac
	done
fi

