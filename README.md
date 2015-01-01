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

## To Do

These are some of the existing known issues. If you know a way to fix these, please send a pull request.

 [] HDHR is not detected because detection is on a random UDP port. Need to figure out a way to specify an IP address and route all traffic to the container.
 [] Set up shared storage for recordings
 [] Password protect the admin pages
