#!/usr/bin/env bash

#
# Root directory.  May be set with `export REPO_ROOT=/foo`.
#

REPO_ROOT=${REPO_ROOT-~/repos}

#
# output usage
#

_repo_usage() {
  echo ""
  echo "  repo [command] <slug>"
  echo ""
  echo "  Supported commands:"
  echo ""
  echo "    help    Show this help text"
  echo "    cd      Literally 'cd <slug>' (default command)"
  echo "    clone   Clone the new repo, then cd to it"
  echo "    rm      Remove the old repo"
  echo ""
  echo "  Supported slug formats:"
  echo ""
  echo "    - gitprovider.com/username/reponame"
  echo "    - username/reponame"
  echo ""
  echo "    The default 'provider' is github.com."
  echo ""
  echo "  Examples:"
  echo ""
  echo "    # cd to somebody/somerepo"
  echo "    $ repo somebody/somerepo"
  echo ""
  echo "    # clone somebody/somerepo"
  echo "    $ repo clone somebody/somerepo"
  echo ""
  echo "    # remove somebody/somerepo"
  echo "    $ repo rm somebody/somerepo"
  echo ""
}

#
# cd to the the repo
#

_repo_cd() {
  # exit on error
  set +e

  local dir="${REPO_ROOT}/$1/$2/$3"

  # ensure it exists
  mkdir -p "${dir}"
  cd "${dir}"
}

#
# clone the given the repo, then cd to it
#

_repo_clone() {
  # exit on error
  set +e

  local provider="$1"
  local user="$2"
  local repo="$3"
  local parent="${REPO_ROOT}/${provider}/${user}"
  local dest="${parent}/${repo}"

  # ensure parent dirs are there
  mkdir -p "${parent}"
  # clone repo
  git clone "git@${provider}:${user}/${repo}.git" "${dest}"
  # cd to newly cloned repo
  cd "${dest}"
}

#
# rm -rf the repo
#

_repo_rimraf() {
  # exit on error
  set +e
  local dir="${REPO_ROOT}/$1/$2/$3"
  rm -rf "${dir}"
}

#
# main
#

repo() {
  local cmd="$1"
  local slug="$2"

  # help
  if [[ "$cmd" = "help" ]] || [[ "$cmd" = "--help" ]] ; then
    _repo_usage
    return 0
  fi

  # validate args
  if [[ -z "$cmd" ]]; then
    echo "repository slug required" >&2
    return 1
  elif [[ -z "$slug" ]]; then
    # optional command
    slug="${cmd}"
    cmd="cd"
  fi

  # parse slug into provider, user & repo
  IFS='/' read -a parts <<< "$slug"
  len=${#parts[@]}
  provider="github.com"
  user=""
  repo=""
  if [[ $len -eq 3 ]]; then
    provider="${parts[0]}"
    user="${parts[1]}"
    repo="${parts[2]}"
  elif [[ $len -eq 2 ]]; then
    user="${parts[0]}"
    repo="${parts[1]}"
  else
    echo "invalid repo slug" >&2
    return 1
  fi

  # run cmd
  case $cmd in
    "cd")
      _repo_cd $provider $user $repo
      return $?
      ;;
    "clone")
      _repo_clone $provider $user $repo
      return $?
      ;;
    "rm")
      _repo_rimraf $provider $user $repo
      return $?
      ;;
    *)
      echo "" >&2
      echo "  '${cmd}' is not a valid command" >&2
      echo "" >&2
      _repo_usage >&2
      return 1
      ;;
  esac
}
