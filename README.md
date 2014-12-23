Docker TVHeadend
================

This is a Docker container that contains [TVHeadend](https://tvheadend.org/)

[WIP] It includes drivers and settings to configure an HDHomeRun tuner.

It also will present the web interface to the user to scan and configure channels.

Build with

```
docker build -t tvheadend .
```

run with

```
docker run -d -p 9991:9991 -p 9981:9981 tvheadend
```

*WARNING* security is set to be non-existant on the web interface. Logging in requires no username or password.

You can set a password via the web interface but configuration is not saved unless you locally mount the /home/hts/.hts folder somewhere.

```
docker run -d -p 9991:9991 -p 9981:9981 -v ${pwd}:/home/hts/.hts tvheadend
```
