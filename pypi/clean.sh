#!/usr/bin/env bash

rm -fr build dist
find src -name __pycache__ | xargs rm -fr
find src -name "*.egg-info" | xargs rm -fr