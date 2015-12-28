# Example Intersphinx Repository

This repository demonstrates using Intersphinx with indexes being exported in Docker volume.

## Scaffolding initial docs:

```sh
docker run -ti --rm -v $(pwd):/mnt/docs:rw -w /mnt/docs apiaryio/base-sphinx-doc-dev sphinx-quickstart
```
