<div id="top"></div>

# Dell iDRAC fan controller Docker image
https://hub.docker.com/repository/docker/tigerblue77/dell_idrac_fan_controller

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#container-console-log-example">Container console log example</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#parameters">Parameters</a></li>
    <li><a href="#contributing">Contributing</a></li>
  </ol>
</details>

## Container console log example

![image](https://user-images.githubusercontent.com/37409593/163174925-d3d20ed6-0f95-44e6-827d-368939435ba4.png)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE -->
## Usage

1. with local iDRAC:

```bash
docker run -d \
  --name Dell_iDRAC_fan_controller \
  --restart=unless-stopped \
  -e IDRAC_HOST=local \
  -e FAN_SPEED=<dec or hex fan speed> \
  -e CPU_TEMPERATURE_TRESHOLD=<dec temperature treshold> \
  -e CHECK_INTERVAL=<seconds between each check> \
  --device=/dev/ipmi0:/dev/ipmi0:rw \
  tigerblue77/dell_idrac_fan_controller:latest
```

2. with LAN iDRAC:

```bash
docker run -d \
  --name Dell_iDRAC_fan_controller \
  --restart=unless-stopped \
  -e IDRAC_HOST=<iDRAC host IP> \
  -e IDRAC_USERNAME=<iDRAC username> \
  -e IDRAC_PASSWORD=<iDRAC password> \
  -e FAN_SPEED=<dec or hex fan speed> \
  -e CPU_TEMPERATURE_TRESHOLD=<dec temperature treshold> \
  -e CHECK_INTERVAL=<seconds between each check> \
  tigerblue77/dell_idrac_fan_controller:latest
```

`docker-compose.yml` examples:

1. to use with local iDRAC:

```yml
version: '3'

services:
  Dell_iDRAC_fan_controller:
    image: tigerblue77/dell_idrac_fan_controller:latest
    container_name: Dell_iDRAC_fan_controller
    restart: unless-stopped
    environment:
      - IDRAC_HOST=local
      - FAN_SPEED=<dec or hex fan speed>
      - CPU_TEMPERATURE_TRESHOLD=<dec temperature treshold>
      - CHECK_INTERVAL=<seconds between each check>
    devices:
      - /dev/ipmi0:/dev/ipmi0:rw
```

2. to use with LAN iDRAC:

```yml
version: '3'

services:
  Dell_iDRAC_fan_controller:
    image: tigerblue77/dell_idrac_fan_controller:latest
    container_name: Dell_iDRAC_fan_controller
    restart: unless-stopped
    environment:
      - IDRAC_HOST=<iDRAC IP address>
      - IDRAC_USERNAME=<iDRAC username>
      - IDRAC_PASSWORD=<iDRAC password>
      - FAN_SPEED=<dec or hex fan speed>
      - CPU_TEMPERATURE_TRESHOLD=<dec temperature treshold>
      - CHECK_INTERVAL=<seconds between each check>
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- PARAMETERS -->
## Parameters

All parameters are optional as they have default values (including default iDRAC username and password).

- `IDRAC_HOST` parameter can be set to "local" or to your distant iDRAC's IP address. **Default** value is "local".
- `IDRAC_USERNAME` parameter is only necessary if you're adressing a distant iDRAC. **Default** value is "root".
- `IDRAC_PASSWORD` parameter is only necessary if you're adressing a distant iDRAC. **Default** value is "calvin".
- `FAN_SPEED` parameter can be set as a decimal (from 0 to 100%) or hexadecimal value (from 0x00 to 0x64) you want to set the fans to. **Default** value is 5(%).
- `CPU_TEMPERATURE_TRESHOLD` parameter is the T°junction (junction temperature) threshold beyond which the Dell fan mode defined in your BIOS will become active again (to protect the server hardware against overheat). **Default** value is 50(°C).
- `CHECK_INTERVAL` parameter is the time (in seconds) between each temperature check and potential profile change. **Default** value is 60(s).

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>
