# How to Run an R Container in Incus

This step-by-step guide shows how to install Incus, configure it to run containers from Docker Hub images, launch an R container, share a local directory with it, and access its shell.

## 1. Install Incus

Before you begin, you must have Incus installed on your system. You can find detailed installation instructions for various operating systems on the official Linux Containers website.

For official installation guides, please visit:

https://linuxcontainers.org/incus/docs/main/installing/

## 2. Initialize Incus

After installing Incus for the first time, you must initialize it. This one-time setup will guide you through configuring essential settings like storage pools and networks.

```
incus admin init
```

For a detailed guide on the initialization options, visit:

https://linuxcontainers.org/incus/docs/main/howto/initialize/

## 3. List Repositories

Check if the Docker Hub remote repository is already configured in your Incus instance.

```
incus remote list
```

## 4. Add the Docker Hub Repository

If a repository named `docker` is not on the list above, add it. This will enable pulling images from Docker Hub using the OCI protocol.

```
incus remote add docker https://docker.io --protocol=oci
```

## 5. Launch the R Container

Launch a new container named `r-base`, using the official `r-base` image from Docker Hub.

```
incus launch docker:r-base r-base
```

## 6. Mount a Local Directory (Shared Storage)

To share files (e.g., R scripts) between the host machine and the container, mount the current working directory (`$(pwd)`) to the `/data` path inside the container.

```
incus config device add r-base r-base-disk disk source=$(pwd) path=/data shift=true
```

- `shift=true`: This flag automatically adjusts file UID/GIDs to ensure access within the container.
    

## 7. Enter the Container Shell

Connect to the container's shell as a non-root user (UID 1000, which corresponds to the `docker` user inside the image).

Using the `--cwd /data` and `--env HOME=/home/docker` flags, you will start directly in the shared `/data` directory and with the correct home directory.

```
incus exec --user 1000 --cwd /data --env HOME=/home/docker r-base -- bash
```

You can now run R by typing `R`, and you will have access to all your project files in the `/data` directory.
