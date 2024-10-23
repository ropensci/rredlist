# CONTRIBUTING #

### Bugs?

* Submit an issue on the [Issues page](https://github.com/ropensci/rredlist/issues)

### Code contributions

* Fork this repo to your Github account
* Clone your version on your account down to your machine from your account, e.g,. `git clone https://github.com/<yourgithubusername>/rredlist.git`
* Make sure to track progress upstream (i.e., on our version of `rredlist` at `ropensci/rredlist`) by doing `git remote add upstream https://github.com/ropensci/rredlist.git`. Before making changes make sure to pull changes in from upstream by doing either `git fetch upstream` then merge later or `git pull upstream` to fetch and merge in one step
* Make your changes (bonus points for making changes on a new feature branch)
* Run tests!
* Push up to your account
* Submit a pull request to home base at `ropensci/rredlist`

### Testing

This package uses [`vcr`](https://docs.ropensci.org/vcr/) on top of [`testthat`](https://testthat.r-lib.org/) for testing: HTTP requests and responses are saved so that when running tests, the cached things ("cassettes") are used instead of repeated calls to web services.

If you're new to such a testing setup, read [HTTP testing in R](https://books.ropensci.org/http-testing/index.html).

In practice, it means:

* **For new tests** you should add `vcr::use_cassette()` around your function calls that use HTTP, or around whole tests. Check out existing test files. Running a new test the first time will create cassettes in `tests/fixtures/` (i.e., YAML files containing HTTP requests and response). Please commit the cassette with your test.

* If you edit the HTTP request a function or a test is making, delete the corresponding cassette before running the tests. Then commit the changes to the cassette with your changes to the test.

`rredlist` requires an API key to work. When testing locally, you will need to use your own API key to generate new cassettes. The API key would normally be recorded in HTTP requests and responses. However, we've set it up so that `vcr` filters this sensitive data out of the cassettes. **Make sure to never include your own API key when making changes to the codebase, including tests.**

### Also, check out our [discussion forum](https://discuss.ropensci.org)
