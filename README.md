# pivisioning

Zero touch provisioning of custom NixOS images for Raspberry Pi CanSats. This allows us to create reproducible OS builds via Nix and QEMU which can be flashed to an SD card and once given power it is ready to fly. Nix supports cross compilation which is leveraged by the QEMU Container to build the image for the Raspberry Pi whether your host machine is ARM/x86.

## Prerequisites

-   Docker 
-   QEMU 
-   Nix

- Internet connection (for Nix to download dependencies)
- A Raspberry Pi 3 (other models may work but are untested)
- An SD card (8GB or larger recommended)

1.  Clone this repo 
    
    ```sh
    git clone git@github.com:ULAS-HiPR/pivisioning.git
    cd pivisioning
    ```

2.  Install Docker (optionally Docker Desktop) on your host machine [see here](https://docs.docker.com/get-docker/)

3.  Install Nix on your host machine [see here](https://nixos.org/download/)

## Usage

1.  Use `docker` to build the NixOS image for the Raspberry Pi and mount the `output` directory to save the `.img` file:

    ```sh
    docker build -t mach25 -f mach25/Dockerfile --build-arg GOOS=linux --build-arg GOARCH=arm --build-arg RPI_VERSION=4 . && \
docker run --rm -it -v $(pwd)/output:/output mach25
    ```

2.  Check the `output` directory for the `.img` file, and flash with balenaEtcher or equivalent.

## SD Image Usage

1.  Burn the `.img` file in `output` to an SD card with your preferred method.

2.  Insert the SD card into the Raspberry Pi and wait for it to boot.

3.  Wait for NixOS to rebuild and switch (this may take a long time) or SSH into
    the Raspberry Pi, then run the following command to monitor progress:

    ```sh
    journalctl -f -u sd-image-init.service
    ```
