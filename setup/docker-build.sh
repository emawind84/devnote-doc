#!/bin/bash

SCRIPT_BASE_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SCRIPT_NAME="${0##*/}"
DOC_FOLDER=$( cd .. && pwd )

docker run --rm \
--volume $DOC_FOLDER:/opt/sphinx/doc/:ro \
--volume $DOC_FOLDER/_build/html:/usr/share/nginx/html \
dev.sangah.com:5043/sphinx-manual