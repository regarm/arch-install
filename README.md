# arch-install
Arch install scripts.

###### Usage
```git clone http://github.com/regarmanojkumar/arch-install```  
or  
```wget https://github.com/regarmanojkumar/arch-install/archive/master.zip```

###### dhcp connection
```systemctl start dhcpcd```

###### check connectivity
```curl google.com```

###### cyberroam connection sample (if needed)
```curl "https://172.16.1.1:8090/login.xml" -d "username=BE103322013&password=sample&producttype=1&mode=191" -ks```

###### run
```cd arch-install```
```install.sh```