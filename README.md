# arch-install
Arch install scripts.

> Only tested for mbr, BIOS, x86_64, archlinux-2015.09.01-dual.iso  
> Timezone - IST, Lang - en_US.UTF-8 (Though can be edited in script manually in script.)

###### Usage
```git clone http://github.com/regarmanojkumar/arch-install```  
or  
```wget https://github.com/regarmanojkumar/arch-install/archive/master.tar.gz```

###### Partition Guide (Only usage description)
```parted /dev/sdx print```  
```parted /dev/sdx mklabel msdos```  
```parted /dev/sdx mkpart primary ext4 1MB 150GB```  
```parted /dev/sdx set y boot on```  
```parted /dev/sdx mkpart primary linux-swap 150GB 158GB```  
```parted /dev/sdx mkpart primary ext4 158GB 100%'```  

###### dhcp connection
```systemctl start dhcpcd```

###### check connectivity
```curl google.com```

###### cyberroam connection sample (if needed)
```curl "https://172.16.1.1:8090/login.xml" -d "username=BE103322013&password=sample&producttype=1&mode=191" -ks```

###### run
```cd arch-install```  
```install.sh```

##### To install packages specified in ```packages``` file  
```./packages.install```