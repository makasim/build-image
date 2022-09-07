# Build image 

Docker image for testing&building golang applications. It contains often used stuff.

It builds identical alpine\debian images.
In general, you should prefer alpine based image.
Debian could be used where cgo, race detector or something similar is needed.

Could be used with [go-app-template](https://github.com/makasim/go-app-template)

## Build image locally

Clone repo:
```
git clone https://github.com/makasim/build-image.git
cd build-image
```

Exec build.sh:
```
./bin/build.sh debian amd64 build-image:latest
```