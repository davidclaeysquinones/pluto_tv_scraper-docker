# pluto_tv_scraper-docker

This repo builds and Docker image of [pluto_tv_scraper](https://github.com/4v3ngR/pluto_tv_scraper).<br>
The purpose is to make the deployment easier and more suitable for different environments.<br>
As a result an m3u8 playlist and xmltv file will be generated for pluto TV.

The original repository of this image is hosted on https://git.claeyscloud.com/david/pluto_tv_scraper-docker.<br>
A public mirror is available at https://github.com/davidclaeysquinones/pluto_tv_scraper-docker.

## Dependencies
[Node](https://nodejs.org/en)<br>

The image is based on `node:23-alpine` in order to be more lightweight.

## Docker image


### Paths

#### Config

The settings file is located under `/config/config.json`.
Under the `mapping` section you can specify which IP adresses are used to obtain the channels in a certain country.
By default some IP adresses are provided in the default configuration file, however these might not work over time.
You can use [ip2location by country](https://lite.ip2location.com/ip-address-ranges-by-country) and [ip2location lookup](https://www.iplocation.net/ip-lookup) to obtain an IP in a certain country.

For each country a `.m3u8` and `.xml` file will be generated.
The expected formats are `plutotv_{country}.m3u8` and `plutotv_{country}.xml`.
If you include more than one country in the mapping section `plutotv_all.m3u8` and `plutotv_all.xml` also will be generated.

##### Options:

| Variable                      | Description                                                                          | Default                                |
|-------------------------------|------------------------------------------------------------------------------------- |----------------------------------------|
| outdir                        | The destination directory where the generated files will be stored.                  | `/public`                              |
| clientID                      | Client id used to connect to the server.                                             | `00000000-0000-0000-0000-000000000000` |
| all                           | Merge all regions into a single playlist and epg.                                    | true                                   |
| chno                          | Start channel numbering at the provided value, spans all regions.                    | N/A                                    |
| group                         | Specify the grouping within the playlist.                                            | `genre`                                |
| regionalize                   | Append the country code to the channel id.                                           | true                                   |
| excludeGroups                 | Exclude the groups that match the regular expression.<br>An example value could be `^Local News$`, `Español` or `(News\|Español)` | false                                  |
| excludeChannels               | Exclude the channels that match the regular expression.                              | false                                  |
| uniqueClientid                | Generate a unique id for each client requesting the playlist via the inbuilt server. | true                                   |
| randomClientid                | Generate a random id for each request of the playlist via the the inbuilt server.    | true                                   |
| refresh                       | Automatically refetch the files at the provided interval (in seconds).               | 3600                                   |
| xTvgUrl                       | Specify a custom x-tvg-url value in the EXTM3U header.                               | false                                  |

### Compose file

```sh
version: '3.3'
services:
  epg:
    image: git.claeyscloud.com/david/pluto-tv-scraper:latest
    #image: ghcr.io/davidclaeysquinones/pluto-tv-scraper:latest
    #image: davidquinonescl/pluto-tv-scraper:latest
    volumes:
      # add a mapping in order to add a custom config file
      #- /docker/pluto:/config
    ports:
      - 5050:5050
    environment:
      # specify the time zone for the server
      - TZ=Etc/UTC
    restart: unless-stopped
```

### Versions

- 1.0.0 &nbsp;
  1.1.21
- 1.0.1 &nbsp;
  1.1.24
- 1.0.2 &nbsp;
  1.1.24<br>
  Update with an updated version that isn't published on the npm registry