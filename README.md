# IDRAC Fan Controller Docker Image

> Note: This repository has been abandoned for quite a while now as I no longer own any Dell servers. [tigerblue77](https://github.com/tigerblue77) has created an excellent [fork](https://github.com/tigerblue77/Dell_iDRAC_fan_controller_Docker) that improves heavily on what I did here. I recommend you use that instead.

To use, 

`docker run -e IDRAC_HOST=<host ip> -e IDRAC_USER=<username> -e IDRAC_PW=<password> -e FAN_SPEED=<dec or hex fan speed> alombardo4/idrac-fan-control:latest`

`FAN_SPEED` can be set as a decimal or hexadecimal value (0x00 to 0x64). Default value is 5 (%).

`docker-compose.yml` examples:

1. to use with local iDRAC:

```yml
version: '3'

services:
  Dell_iDRAC_fan_controller:
    image: alombardo4/idrac-fan-control
    restart: unless-stopped
    environment:
      - IDRAC_HOST=local # can be omitted as it is the default value
      - FAN_SPEED=0x05 # set to the decimal or hexadecimal value you want to set the fans to (from 0 to 100%)
    devices:
      - /dev/ipmi0:/dev/ipmi0
```

2. to use with LAN iDRAC:

```yml
version: '3'

services:
  Dell_iDRAC_fan_controller:
    image: alombardo4/idrac-fan-control
    restart: unless-stopped
    environment:
      - IDRAC_HOST=192.168.1.100 # override to the IP of your IDRAC
      - IDRAC_USER=root # set to your IPMI username
      - IDRAC_PW=calvin # set to your IPMI password
      - FAN_SPEED=0x05 # set to the decimal or hexadecimal value you want to set the fans to (from 0 to 100%)
      - MAXTEMP=32 # set the maximum temperature (in celcius) before dynamic fan control kicks back in, optional, defaults to 32
```
