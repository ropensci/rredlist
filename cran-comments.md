This is a resubmission. I have addressed the NOTEs raised from my previous submission. However, I'm not sure how to resolve this NOTE:
"Author field differs from that derived from Authors@R"

I believe this is referring to a difference between the DESCRIPTION file and the rredlist-package documentation file. However, the latter is generated automatically based on the former, so they should match. It appears there may be an issue processing the ROR comment?

## Test environments (with Github Actions)

* Windows 10.0.20348 (x86_64-w64-mingw32): R 4.5.1
* Mac OS X 14.7.6 (aarch64-apple-darwin20): R 4.5.1
* Ubuntu 24.04.2 (x86_64-pc-linux-gnu): R 4.4.3, 4.5.1, and devel (r88411)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Downstream dependencies

Checked 1 reverse dependency, comparing R CMD check results across CRAN and dev versions of this package:

 * taxize (0.10.0)

### Dependency check results:
All packages passed.