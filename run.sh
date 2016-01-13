#!/bin/bash
drone-docker <<EOF
{
	"workspace": {
		"path": "./docker/src"
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
		"password": "password",
		"email": "foo@bar.com",
		"repo": "foo/bar",
		"storage_driver": "aufs"
	}
}
EOF
