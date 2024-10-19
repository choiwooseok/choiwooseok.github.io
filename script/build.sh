#! /bin/bash

cd ..

rm -rf docs/*

flutter build web --release

cp -r build/web/* docs/
