#!/bin/bash

SPHINX_IMAGE_NAME="apiaryio/base-sphinx-doc-dev"
TAG_NAME="apiaryio/example-intersphinx-repo-shared-inventories"
CONTAINER_NAME="example-intersphinx-repo-shared-inventories-volume"

(
	cd "./example-standalone-docs/" && \
	docker run -ti --rm -v $(pwd):/mnt/docs:rw -w /mnt/docs $SPHINX_IMAGE_NAME
) && \

cp ./example-standalone-docs/build/html/objects.inv ./shared-invs/inventories/other-project.inv && \

(
	cd "./shared-invs" && \
	docker build -t $TAG_NAME .
) && \

docker create -v /inventories --name=$CONTAINER_NAME $TAG_NAME /bin/true && \

(
	cd "./example-intersphinx-project/" && \
	docker run -ti --rm -v $(pwd):/mnt/docs:rw -w /mnt/docs --volumes-from=$CONTAINER_NAME $SPHINX_IMAGE_NAME
)

exitcode=$?

docker rm $CONTAINER_NAME > /dev/null

exit $exitcode
