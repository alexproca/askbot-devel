#!/bin/bash
pushd ..
python setup.py sdist
popd
cp ../dist/* .

