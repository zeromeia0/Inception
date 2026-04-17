# Developer Documentation

## Overview

This project is a multi-container architecture built using Docker and Docker Compose.  
It consists of three main services:

- NGINX: reverse proxy handling HTTPS (TLSv1.2 / TLSv1.3)
- WordPress: PHP-FPM application running WordPress
- MariaDB: relational database storing persistent data

Each service is built from a custom Dockerfile and runs in an isolated container.  
All services communicate through a Docker bridge network.

---

## Environment Setup

### Prerequisites

- Linux Virtual Machine
- Docker installed
- Docker Compose installed

---

### Project Structure

- `srcs/docker-compose.yml`: defines services, volumes, networks, and secrets
- `srcs/requirements/`: contains all service definitions
  - `nginx/`: Dockerfile, config, and setup script
  - `wordpress/`: Dockerfile, config, and setup script
  - `mariadb/`: Dockerfile, config, and setup script
- `secrets/`: stores sensitive data (passwords)
- `Makefile`: entry point to build and manage the project

---

### Configure Secrets

Before running the project, ensure all files inside `secrets/` contain valid values.

These include:
- database passwords
- WordPress admin password
- WordPress user password

---

### Configure Environment Variables

Edit the `.env` file inside `srcs/.env`

This file defines:
- database name
- database user
- domain name
- WordPress configuration values

---

## Build and Launch

To build and start the project:

```bash
make up
````

This command will:

* build all Docker images from Dockerfiles
* create containers
* attach volumes
* connect services through the network
* start all containers

---

## Manage Containers and Volumes

### Stop containers

```bash
make down
```

---

### Restart containers

```bash
make restart
```

---

### View logs

```bash
make logs
```

---

### Check running containers

```bash
make status
```

---

### Access containers

```bash
make gtm   # MariaDB container
make giw   # WordPress container
make gin   # NGINX container
```

---

### Clean environment

```bash
make clean
```

Removes:

* containers
* images
* volumes

---

## Data Storage and Persistence

Data persistence is handled using Docker volumes.

Volumes are mapped to the host machine at:

```
/home/vivaz-ca/data/
```

Structure:

* `/home/vivaz-ca/data/mariadb`: stores database files
* `/home/vivaz-ca/data/wordpress`: stores WordPress files

These volumes ensure:

* data is preserved after container restart
* data is not lost when containers are removed

---

## Networking

A custom Docker bridge network is defined:

```
inception
```

This allows communication between containers:

* NGINX → WordPress via FastCGI
* WordPress → MariaDB via TCP

Services communicate using container names as hostnames.

---

## Initialization Logic

### MariaDB

* initializes database if not already present
* creates database and users
* sets passwords using Docker secrets
* uses a flag file to avoid re-running setup

---

### WordPress

* waits for MariaDB to be ready
* installs WordPress if not already configured
* creates admin and standard user using WP-CLI
* sets correct file permissions

---

## Notes

* No passwords are hardcoded in Dockerfiles
* Docker secrets are used for sensitive data
* Containers use `exec` to ensure proper PID 1 behavior
* No infinite loops or unsafe practices are used
* All services are isolated and follow Docker best practices
