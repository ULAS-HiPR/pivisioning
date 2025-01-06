docker build -t mach25 -f nixos-rpi-sd-image/Dockerfile --build-arg GOOS=linux --build-arg GOARCH=arm --build-arg RPI_VERSION=4 . && \
docker run --rm -it -v $(pwd)/output:/output mach25
