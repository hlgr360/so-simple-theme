#! /bin/bash
# script inspired by 
# 	http://varunbpatil.github.io/2013/07/06/jekyll-build-fail/#.WZV5qK2B3re
#	http://pauldambra.github.io/using-travis-to-build-jekyll.html
set -e

DEPLOY_REPO="https://${DEPLOY_BLOG_TOKEN}@github.com/hlgr360/blog.git"

function main {
	# only require checkout when running locally
	# clean
	# get_source
	build_site
    deploy
}

function clean {
	echo "cleaning folder"
	if [ -d "blog" ]; then rm -Rf blog; fi
}

function get_source {
	echo "getting source"
	git clone --depth 1 $DEPLOY_REPO
}

function build_site {
	echo "building site"
	
	# if build with a local clone of the source 
	# cd blog
	bundle exec jekyll build
}

function deploy {
	echo "deploying changes"

	if [ -z "$TRAVIS_PULL_REQUEST" ]; then
	    echo "except don't publish site for pull requests"
	    exit 0
	fi

	if [ "$TRAVIS_BRANCH" != "master" ]; then
	    echo "except we should only publish the master branch. stopping here"
	    exit 0
	fi

	# if build with a local clone of the source 
	# cd blog/_site
	cd _site
	git init
	git config --global user.name "Travis CI"
    git config --global user.email deploy@launchd.de
  	git add .
	git commit -m "Build $TRAVIS_BUILD_NUMBER deployed to github"
	git push $DEPLOY_REPO master:gh-pages --force
}

main