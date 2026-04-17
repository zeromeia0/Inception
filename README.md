
*This project has been created as part of the 42 curriculum by vivaz-ca.*

# Inception

## Description

This project consists of building a small infrastructure using Docker and Docker Compose. The goal is to deploy multiple services in isolated containers and make them communicate with each other to provide a complete web application environment.

The infrastructure includes:
- NGINX acting as a reverse proxy with HTTPS support (TLSv1.2 and TLSv1.3)
- WordPress with PHP-FPM handling dynamic content
- MariaDB as the database system

Each service is built from a custom Dockerfile based on Debian and runs in its own container. The services are connected through a Docker bridge network and use volumes to ensure data persistence.

This project demonstrates:
- Containerization principles
- Service isolation
- Inter-container networking
- Secure credential handling using Docker secrets
- Persistent storage using Docker volumes


## Instructions

### Requirements
- Linux Virtual Machine
- Docker
- Docker Compose

### Setup

Clone the repository:
```bash
git clone git@github.com:zeromeia0/Inception.git
cd Inception
make
```

## Project Description and Design

### Use of Docker

Docker is used to create isolated environments called containers. Each service runs in its own container, ensuring clear separation of responsibilities.

- NGINX handles HTTPS requests and acts as a reverse proxy
- WordPress handles PHP execution using PHP-FPM
- MariaDB stores and manages database data

Docker Compose is used to orchestrate the entire system. It defines all services, networks, volumes, and secrets in a single configuration file, allowing the infrastructure to be launched with a single command.

---

### Virtual Machines vs Docker

- Docker containers share the host kernel and are lightweight
- Virtual machines run a full operating system and are heavier
- Docker starts faster and uses fewer resources
- Virtual machines provide stronger isolation but at a higher cost

---

### Secrets vs Environment Variables

- Environment variables are used for non-sensitive configuration such as domain names and usernames
- Docker secrets are used for sensitive data such as passwords
- Secrets are stored securely and mounted inside containers at runtime
- This prevents credentials from being exposed in Dockerfiles or configuration files

---

### Docker Network vs Host Network

- A Docker bridge network is used to allow containers to communicate internally
- Each service can reach the others using their service name (e.g., `nginx` → `wordpress` → `mariadb`)
- Host network mode is not used because it removes isolation and is forbidden by the subject

---

### Docker Volumes vs Bind Mounts

- Docker volumes are used to persist data independently of the container lifecycle
- Data is stored in:
  * `/home/vivaz-ca/data/mariadb`
  * `/home/vivaz-ca/data/wordpress`
- Volumes ensure data is not lost when containers are removed or recreated
- Bind mounts directly link host paths but are less portable

---

## Resources

- Docker documentation: [https://docs.docker.com/](https://docs.docker.com/)
- Docker Compose documentation: [https://docs.docker.com/compose/](https://docs.docker.com/compose/)
- NGINX documentation: [https://nginx.org/en/docs/](https://nginx.org/en/docs/)
- MariaDB documentation: [https://mariadb.org/documentation/](https://mariadb.org/documentation/)
- WordPress documentation: [https://wordpress.org/support/](https://wordpress.org/support/)

### AI Usage

AI tools were used to:
- Clarify Docker concepts and architecture
- Understand configuration files such as NGINX, MariaDB, and PHP-FPM
- Review scripts and improve explanations

All generated content was reviewed, tested, and fully understood before being included in the project.
```