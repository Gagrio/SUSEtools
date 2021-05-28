## Docker image building script
- What is this?
>  This is a docker image building script to help with building DOCKER_BUILDKIT images with SCC Credentials.
- How does it work?
> The script has a few requirements:
>  - It needs to be in the same directory with Dockerfile and SCCcredentials file
>  - The Dockerfile must be tagged for DOCKER_BUILDKIT (in first line)
>  - It needs to have exactly two parameters from command line:
>    - the image name
>    - the tag name
>  Once all requirements are met it simply builds the image for you.
- Example usage:
```
[george@localhost: ~/suse-it-wiki/suse-docker-image]$  ruby image-builder.rb gagrio1885/suse-wiki-1_27_7 latest
Step 1: Checking SCCcredentials
OK
Step 2: Checking Dockerfile
OK
First argument should be the image name
OK
Second argument should be the tag name
OK
Step 3: Checking BUILDKIT syntax requirements
[+] Building 173.8s (18/18) FINISHED                                                                                                                       
 => [internal] load build definition from Dockerfile                                                                                                  0.0s
 => => transferring dockerfile: 37B                                                                                                                   0.0s
 => [internal] load .dockerignore                                                                                                                     0.0s
 => => transferring context: 2B                                                                                                                       0.0s
 => resolve image config for docker.io/docker/dockerfile:experimental                                                                                 0.9s
 => CACHED docker-image://docker.io/docker/dockerfile:experimental@sha256:600e5c62eedff338b3f7a0850beb7c05866e0ef27b2d2e8c02aa468e78496ff5            0.0s
 => [internal] load build definition from Dockerfile                                                                                                  0.0s
 => => transferring dockerfile: 37B                                                                                                                   0.0s
 => [internal] load metadata for registry.suse.com/suse/sle15:15.2                                                                                    0.4s
 => [ 1/10] FROM registry.suse.com/suse/sle15:15.2@sha256:48f7e1a3ba7a04e75037cca6958434f54f160d3b14a431cb1657e84cf19d8413                            4.7s
 => => resolve registry.suse.com/suse/sle15:15.2@sha256:48f7e1a3ba7a04e75037cca6958434f54f160d3b14a431cb1657e84cf19d8413                              0.0s
 => => sha256:48f7e1a3ba7a04e75037cca6958434f54f160d3b14a431cb1657e84cf19d8413 1.42kB / 1.42kB                                                        0.0s
 => => sha256:42eeeec29b50772c7f282d6ec4f86cc5908fb1dd5dcc5cc1cf918dda3800f5bb 539B / 539B                                                            0.0s
 => => sha256:89f7861fd8f6daeaa6f943f81f8dfa22836a8f8438834711e6fadea4f6d3407b 1.70kB / 1.70kB                                                        0.0s
 => => sha256:8fcff428c6fb91e4802b74e24e6b6055fec8aab92d9890e91084562c199981a2 45.55MB / 45.55MB                                                      0.9s
 => => extracting sha256:8fcff428c6fb91e4802b74e24e6b6055fec8aab92d9890e91084562c199981a2                                                             3.2s
 => [internal] load build context                                                                                                                     0.0s
 => => transferring context: 39B                                                                                                                      0.0s
 => [ 2/10] RUN --mount=type=secret,id=SCCcredentials,required     zypper --non-interactive --gpg-auto-import-keys up &&     zypper --non-interact  141.7s
 => [ 3/10] RUN a2enmod php7                                                                                                                          0.9s
 => [ 4/10] RUN a2enflag SSL                                                                                                                          0.9s 
 => [ 5/10] RUN sed -i 's/^variables_order = "GPCS"/variables_order = "EGPCS"/g' /etc/php7/apache2/php.ini                                            0.7s 
 => [ 6/10] RUN echo "ServerName 127.0.0.1" >> /etc/apache2/httpd.conf                                                                                0.8s 
 => [ 7/10] WORKDIR /tmp                                                                                                                              0.0s 
 => [ 8/10] RUN curl -o /tmp/mediawiki.tar.gz https://releases.wikimedia.org/mediawiki/1.27/mediawiki-1.27.7.tar.gz &&     tar xvf mediawiki.tar.gz   9.6s 
 => [ 9/10] COPY LocalSettings.php /srv/www/htdocs/LocalSettings.php                                                                                  0.0s 
 => [10/10] WORKDIR /srv/www/htdocs                                                                                                                   0.0s 
 => exporting to image                                                                                                                               12.0s 
 => => exporting layers                                                                                                                              12.0s 
 => => writing image sha256:261498528971616a8bca62b08d0e196df731011c773ed2eb09619880e07ac259                                                          0.0s 
 => => naming to docker.io/gagrio1885/suse-wiki-1_27_7:latest                                                                                         0.0s 
```
### To do - enhancements
- Print usage
- Better messages maybe
- make `--no-cache --pull` optional
- Leave your comment below
- Like and subscribe
- Woops that's from different platform
