# IDRAC Fan Controller Docker Image

To use, 

`docker run -e IDRAC_HOST=<host ip> -e IDRAC_USER=<username> -e IDRAC_PW=<password> -e FANSPEED=<hex fan speed> alombardo4/idrac-fan-control:latest`

`FANSPEED` should be set as a hex value, e.g. `0x05`

Example `docker-compose.yml`:

```yml
version: '3'

services:
  fan-controller:
    image: alombardo4/idrac-fan-control
    environment:
      - IDRAC_HOST=192.168.1.100 # override to the IP of your IDRAC
      - IDRAC_USER=root # set to your IPMI username
      - IDRAC_PW=calvin # set to your IPMI password
      - FANSPEED=0x05 # set to the hex value you want to set the fans to (from 0 to 100)
```
