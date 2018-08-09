#!/usr/bin/env bash

mirror () {
  echo "Mirroring $1"

  if ! git config remote.$1.url > /dev/null; then
    echo "Adding origin $1"
    git remote add ${1} git@github.com:hiendv/${1}.git
  fi

  sha=$(./splitsh-lite --prefix packages/$1 --quiet)
  echo "Pushing: $1 $sha:refs/heads/master"
  git push -u $1 $sha:refs/heads/master
}

for d in packages/*; do
  if [ -d ${d} ]; then
    mirror ${d##*/}
  fi
done
