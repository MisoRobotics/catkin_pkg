.PHONY: all setup clean_dist distro clean install testsetup test

NAME=catkin-pkg
VERSION=`./setup.py --version`

all:
	echo "noop for debbuild"

setup:
	echo "building version ${VERSION}"

clean_dist:
	-rm -f MANIFEST
	-rm -rf dist
	-rm -rf deb_dist

distro: setup clean_dist
	python setup.py sdist

clean: clean_dist
	echo "clean"

install: distro
	eval 'sudo -E checkinstall --default --nodoc --provides="$(NAME)" --pkgsource="$(NAME)" --pkgname="$(NAME)" --pkgversion="$(VERSION)" --maintainer="Ryan Sinnet \<rsinnet@misorobotics.com\>" python setup.py install'

testsetup:
	echo "running ${NAME} tests"

test: testsetup
	cd test && nosetests && nosetests3
