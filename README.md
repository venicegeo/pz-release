# pz-release

The pz-release project is software that is used to aggregate both a consolidated version for Piazza and individual versions for microservice subcomponents. 

***
## Requirements
Before building and running the pz-release project, please ensure that the following components are available and/or installed, as necessary:
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) (for checking out repository source)

For additional details on prerequisites, please refer to the Piazza Developer's Guide repository content for [Core Overview](https://github.com/venicegeo/pz-docs/blob/master/documents/devguide/02-pz-core.md) or the [prerequisites for using Piazza](https://github.com/venicegeo/pz-docs/blob/master/documents/devguide/03-jobs.md) section for additional details.

***
## Setup

Create the directory the repository must live in, and clone the git repository:

    $ mkdir -p {PROJECT_DIR}/src/github.com/venicegeo
    $ cd {PROJECT_DIR}/src/github.com/venicegeo
    $ git clone git@github.com:venicegeo/pz-release.git

## Configuring
### Configuring Applications
To edit the application components that are to be included in the release, open _config/apps.txt_ and edit to include the necessary application components.

### Configuring Repositories
To edit the repositories that are to be included in the release, open _config/repos.txt_ and edit to include the necessary repositories.

