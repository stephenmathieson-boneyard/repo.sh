
# repo.sh

  Simple shell script for managing repositories.


## Installation

  Clone this repository, then add something like this to your `~/.bashrc`:

```sh
source /path/to/repo.sh
```

## Usage

```sh
$ repo help

  repo [command] <slug>

  Supported commands:

    help    Show this help text
    cd      Literally 'cd <slug>' (default command)
    clone   Clone the new repo, then cd to it
    rm      Remove the old repo

  Supported slug formats:

    - gitprovider.com/username/reponame
    - username/reponame

    The default 'provider' is github.com.

  Examples:

    # cd to somebody/somerepo
    $ repo somebody/somerepo

    # clone somebody/somerepo
    $ repo clone somebody/somerepo

    # remove somebody/somerepo
    $ repo rm somebody/somerepo

```

## Default Repository Root

  By default, all repositories will be cloned into `~/repos`.  You may override this behavior by setting the `REPO_ROOT` environment variable:

```sh
$ export REPO_ROOT=/some/other/place
```

## License 

(The MIT License)

Copyright (c) 2014 Stephen Mathieson &lt;me@stephenmathieson.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.