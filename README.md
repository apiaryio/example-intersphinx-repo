# Example Intersphinx Repository

This repository demonstrates a possible approach for maintaining a collection internal, cross-referenced documentations.

It relies on Sphinx's [intersphinx extension](http://sphinx-doc.org/latest/ext/intersphinx.html).

Idea revolves around having a shared repository with all inventories (indexes) for all projects. Those can then be reused and referenced by other documentations. Index is updated after build (every project must update its inventory file) and stored in a docker repository to reuse build and authentication structure that's already in place for it.

## Repository Structure

* `example-standalone-docs` contains minimal spinx documentation with glossary that defines a term
* `shared-invs` is a "dummy folder" that contains inventory artifacts. After build, `objects.inv` index file (required by intersphinx) is copied there (as `other-project.inv`)
* `example-intersphinx-project` references a term defined in `example-standalone-docs`. Take a look at:
	* [index.rst](example-intersphinx-project/source/index.rst) to discover how a term can be referenced
	* [conf.py](example-intersphinx-project/source/conf.py) to discover how intersphinx is set up

## Build Process

Run `./build.sh`.

The whole build relies on Docker, and utilises Apiary's [base Sphinx image](https://github.com/apiaryio/docker-base-images/tree/master/sphinx-doc-dev).

* Build `example-standalone-docs`
* Copy its inventory file to shared inventory folder
* Build minimalistic Docker image out of it
* Mount it as a volume to `example-standalone-docs`
* Build `example-standalone-docs`
* In this case, remove interim `shared-inventory` container

The whole idea, of course, is for `shared-inventory` to be preserved in Docker registry.

---

## Dev notes

### Scaffolding initial docs:

```sh
docker run -ti --rm -v $(pwd):/mnt/docs:rw -w /mnt/docs apiaryio/base-sphinx-doc-dev sphinx-quickstart
```
