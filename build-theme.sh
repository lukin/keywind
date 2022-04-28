#!/bin/bash

# build theme template
cd keywind
pnpm install
pnpm build
cp -R theme ../package/src/main/resources/

# build jar file
cd ../package
sh gradlew jar