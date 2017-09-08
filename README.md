# docker-aptly

[![Build Status](https://travis-ci.org/osism/docker-aptly.svg?branch=master)](https://travis-ci.org/osism/docker-aptly)
[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-osism%2Faptly-blue.svg)](https://hub.docker.com/r/osism/aptly/)

Notes
-----

```console
gpg: Generating a GPG key, might take a while

Not enough random bytes available.  Please do some other work to give
the OS a chance to collect more entropy! (Need 282 more bytes)
```

At the first start this is normal. Generate entropy on the host system, e.g. by using find, ping, or [haveged](http://www.issihosts.com/haveged/).

License
-------

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Author information
------------------

This Docker image was provided by [Betacloud Solutions GmbH](https://www.betacloud-solutions.de).

Based on https://github.com/bryanhong/docker-aptly.

Notices
-------

Docker and the Docker logo are trademarks or registered trademarks of Docker, Inc. in the
United States and/or other countries. Docker, Inc. and other parties may also have trademark
rights in other terms used herein.

This product contains software (https://github.com/bryanhong/docker-aptly) developed
by Bryan Hong (http://github.com/bryanhong), and Jan Čapek (https://github.com/honzik666),
licensed under the Apache License.
