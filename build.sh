#!/bin/bash

(
	cd "./example-standalone-docs/" && \
	docker run -ti --rm -v $(pwd):/mnt/docs:rw -w /mnt/docs apiaryio/base-sphinx-doc-dev
) && \

cp ./example-standalone-docs/build/html/objects.inv ./shared-invs/inventories/other-project.inv && \

(
	cd "./shared-invs" && \
	docker build -t example-intersphinx-repo-shared-inventories . 
) && \

docker create -v /inventories --name example-intersphinx-repo-shared-inventories example-intersphinx-repo-shared-inventories /bin/true && \

(
	cd "./example-intersphinx-project/" && \
	docker run -ti --rm -v $(pwd):/mnt/docs:rw -w /mnt/docs --volumes-from=example-intersphinx-repo-shared-inventories apiaryio/base-sphinx-doc-dev
)

exitcode=$?

docker rm example-intersphinx-repo-shared-inventories

exit $exitcode