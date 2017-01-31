Skeleton
========

Skeleton is a bare bones starter pack for new golang projects.  It includes the following features:

* Skeleton main.go with command line parsing and version support
* Basic tests to show the way
* Support for:
  * [govendor](https://github.com/kardianos/govendor)
  * [Docker](https://www.docker.com)
  * [direnv](http://direnv.net)
* Makefile's for:
  * Running tests
  * Building - native and cross compilation
  * Managing go dependencies (through govendor)
  * Docker image generation and registry push
  * Docker debugging (shell and attach)
* Sensible .gitignore and .dockerignore

How to use
----------

1. Checkout this repo into a new directory
```shell
cd /tmp
git clone https://github.com/ashmckenzie/go-skeleton new-app
```

2. Remove the .git directory to ensure no history from go-skeleton is retained

3. Edit `.envrc` and replace any `<CHANGE-ME-XXX>` as required

4. Either setup [direnv](http://direnv.net) to work with your shell, or if not, run
```shell
source .envrc
```

5. Ensure govendor is installed
```shell
cd app
make install_govendor
```

6. Run `make` in either
  * The root directory to create a Docker image
  * The app directory to compile as `./bin/<project_name>`

7. Enjoy :)

Useful links
------------

* https://tour.golang.org/welcome/1
* http://gobyexample.com
* https://www.golang-book.com/books/intro
* https://www.golang-book.com/books/intro/12
* https://github.com/kardianos/govendor
* https://nathanleclaire.com/blog/2014/02/15/how-to-wait-for-all-goroutines-to-finish-executing-before-continuing/
* https://nathanleclaire.com/blog/2015/03/09/youre-not-using-this-enough-part-one-go-interfaces/
