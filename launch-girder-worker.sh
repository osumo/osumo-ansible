#!/bin/sh

./venv/bin/girder-worker >girder-worker.log 2>&1
disown
