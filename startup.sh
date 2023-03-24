#!/bin/bash

/etc/init.d/nginx restart
/blobtoolkit/blobtoolkit-api &
BTK_API_URL=/api/v1 /blobtoolkit/blobtoolkit-viewer
