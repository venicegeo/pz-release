# pz-release

The pz-release project is software that is used to release Piazza. At the time of a release, the configured branches for all Piazza components are imported into a single build.

***
## Requirements
Before building and running the pz-release project, please ensure that the following components are available and/or installed, as necessary:
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) (for checking out repository source)

***
## Setup

Create the directory the repository must live in, and clone the git repository:

    $ mkdir -p $GOPATH/src/github.com/venicegeo
    $ cd $GOPATH/src/github.com/venicegeo
    $ git clone git@github.com:venicegeo/pz-release.git

## Configuring
### Configuring Applications
To edit the application components that are to be included in the release, open _config/apps.txt_ and edit to include the necessary application components.

### Configuring Repositories
To edit the repositories that are to be included in the release, open _config/repos.txt_ and edit to include the necessary repositories.

