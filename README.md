# IDRAC Fan Controller Docker Image

- `IDRAC_HOST` parameter can be set to "local" or to your distant iDRAC's IP address. Default value is "local".
- `IDRAC_USERNAME` parameter is only necessary if you're adressing a distant iDRAC. Default value is "root".
- `IDRAC_PASSWORD` parameter is only necessary if you're adressing a distant iDRAC. Default value is "calvin".
- `FAN_SPEED` parameter can be set as a decimal (from 0 to 100%) or hexadecimal value (from 0x00 to 0x64) you want to set the fans to. Default value is 5(%).
- `MAXIMUM_TEMPERATURE` parameter is the threshold beyond which the Dell fan mode defined in your BIOS will become active again (to protect the server hardware against overheat). Default value is 32(°C).

To use:

1. with local iDRAC:

```bash
docker run -d \
  --name Dell_iDRAC_fan_controller \
  --restart unless-stopped \
  -e FAN_SPEED=<dec or hex fan speed> \
  -e MAXIMUM_TEMPERATURE=<dec temp treshold> \
  alombardo4/idrac-fan-control:latest
```

2. with LAN iDRAC:

```bash
docker run -d \
  --name Dell_iDRAC_fan_controller \
  --restart unless-stopped \
  -e IDRAC_HOST=<iDRAC host IP> \
  -e IDRAC_USERNAME=<iDRAC username> \
  -e IDRAC_PASSWORD=<iDRAC password> \
  -e FAN_SPEED=<dec or hex fan speed> \
  -e MAXIMUM_TEMPERATURE=<dec temp treshold> \
  alombardo4/idrac-fan-control:latest
```

`docker-compose.yml` examples:

1. to use with local iDRAC:

```yml
version: '3'

services:
  Dell_iDRAC_fan_controller:
    image: alombardo4/idrac-fan-control
    container_name: Dell_iDRAC_fan_controller
    restart: unless-stopped
    environment:
      - IDRAC_HOST=local # can be omitted as it is the default value
      - FAN_SPEED=0x05 # set to the decimal or hexadecimal value you want to set the fans to (from 0 to 100%)
      - MAXIMUM_TEMPERATURE=<dec temp treshold>
    devices:
      - /dev/ipmi0:/dev/ipmi0
```

2. to use with LAN iDRAC:

```yml
version: '3'

services:
  Dell_iDRAC_fan_controller:
    image: alombardo4/idrac-fan-control
    container_name: Dell_iDRAC_fan_controller
    restart: unless-stopped
    environment:
      - IDRAC_HOST=192.168.1.100 # override to the IP address of your IDRAC
      - IDRAC_USERNAME=root # set to your IPMI username
      - IDRAC_PASSWORD=calvin # set to your IPMI password
      - FAN_SPEED=0x05 # set to the decimal or hexadecimal value you want to set the fans to (from 0 to 100%)
      - MAXIMUM_TEMPERATURE=<dec temp treshold>
```
