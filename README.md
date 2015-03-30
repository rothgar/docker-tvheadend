Docker TVHeadend
================

This is a Docker container that contains [TVHeadend](https://tvheadend.org/)

It includes drivers and settings to configure an HDHomerun tuner compiled statically in the binary.

It also will present the web interface to the user to scan and configure channels.

run with

```
docker run -d --net="host" -v ${pwd}/config:/config -v /path/to/recordings:recordings tvheadend:unstable
```
*INFO* `--net=host` will run the container attached to your physical network interface. This was the only way I could get HDHomerun discovery working properly. You alternatively could used the exposed ports with -p 9981:9981 -p 9982:9982 if you don't need to use an HDHomerun.

*WARNING* security is set to be non-existant on the web interface. Logging in requires no username or password.

You can set a password via the web interface. 

Build with

```
docker build -t tvheadend:unstable .
```
## To Do

These are some of the existing known issues. If you know a way to fix these, please send a pull request.

 - [ x ] HDHR is not detected because detection is on a random UDP port. Need to figure out a way to specify an IP address and route all traffic to the container.
 - [ x ] Set up shared storage for recordings (/root by default)
 - [ ] Password protect the admin pages
 - [ ] Configure guide data
 - [ ] Build with stable release tags

## Issues

Please report issues here on GitHub Issues.
