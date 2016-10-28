для свежеустановленного raspbian{
	- сменить пароль:
		passwd 
	- подключить к интернету:
		sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
		network={
		    ssid="The_ESSID_from_earlier"
		    psk="Your_wifi_password"
		}
		sudo ifdown wlan0
		sudo ifup wlan0
	- sudo apt-get -y update && sudo apt-get -y dist-upgrade
}