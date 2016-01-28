# drone-docker

Drone plugin for publishing Docker images

## About
This fork of the plugin creates image tags based on 6 pieces of information:

 * Owner
 * Repository
 * Branch
 * Version
 * Build number
 * Commit sha slug

The build number is calculated by looking at the number of commits since a version change occured (starting at 1).

It presently reads this information from a `.buildinfo.json` file which we generate in a seperate build step using the Node module `buildgoggles`.

When a tag is generated from `.buildinfo.json` this plugin will also write the name of the resulting Docker image to `.docker.json` in the following data structure:

```json
{
	"image": "your/image:tag"
}
```

## Docker

Build the Docker container:

```sh
docker build --rm=true -t plugins/drone-docker .
```

## Local test
The `run.sh` script will look for a buildinfo file (by default) under `./docker/src/.buildinfo.json` but this can be changed by altering the `workspace.path` passed to the executable in the shell script.

## Example shell script
Build and Publish a Docker container

```sh
docker run -i --privileged -v $(pwd):/drone/src arob/drone-docker <<EOF
{
	"workspace": {
		"path": "/drone/src"
	},
	"build" : {
		"number": 1,
		"head_commit": {
			"sha": "9f2849d5",
			"branch": "master",
			"ref": "refs/heads/master"
		}
	},
	"vargs": {
		"username": "kevinbacon",
		"password": "pa$$word",
		"email": "foo@bar.com",
		"repo": "foo/bar",
		"storage_driver": "aufs"
	}
}
EOF
```
