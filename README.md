# AdGuardHome Docker

AdGuard-Home Docker container for Raspberry Pi (tested with 3+, Zero W).

## Trying out

`docker run --rm -ti -p 53:53/udp -p 53:53/tcp -p 3000:3000 mort3m/adguard-home-raspi`

Now visit `http://<your-ip>:1337`, login is `admin` and password is `admin`..  At this point everything should be working, but changes will not survive if the container is recreated..  See Running below.

## Running

Within the container, `/data/` is where configuration lives.

Run the following to generate the necessary configs:

`docker run --rm -ti -v <your-data-dir>:/data mort3m/adguard-home-raspi`

You an press `CTRL-C` now.

You should now see the following in `<your-data-dir>`:

```
AdGuardHome
AdGuardHome.yaml
Corefile
dnsfilter.txt
```

NOTE: Unfotunately the `AdGuardHome` binary needs to be coupled with the configs (https://github.com/AdguardTeam/AdGuardHome/issues/381) but has been fixed in (https://github.com/AdguardTeam/AdGuardHome/commit/a528ed9f947d42f4324cd4f2263a015d34d7341f).  I will update the image accordingly when there's a new version.

You can now run the container in the background:

`docker run -d -p 53:53/udp -p 53:53/tcp -p 3000:3000 -v <your-data-dir>:/data mort3m/adguard-home-raspi`

## Building

If you'd like to build your own image, simply run `make build`.

# Thanks

Ash McKenzie (https://gitlab.com/ashmckenzie/adguard-home-docker)
