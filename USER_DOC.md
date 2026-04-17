# User Documentation

## Overview

This project provides a complete web stack composed of three main services:

- NGINX: handles HTTPS connections and acts as a reverse proxy
- WordPress: provides the website and administration panel using PHP-FPM
- MariaDB: stores all website data such as users, posts, and configuration

Each service runs inside its own container and communicates through a Docker network.

---

## Start and Stop the Project

To start the project, run:

```bash
make up
```
To stop the project, run:
```bash
make down
```

To restart the project:

```bash
make restart
```

---

## Access the Website and Administration Panel

Open your browser and go to:

```
https://vivaz-ca.42.fr
```

You may need to configure your `/etc/hosts` file to point the domain to your local IP.

To access the WordPress administration panel:

```
https://vivaz-ca.42.fr/wp-admin
```

Login using:

* the admin username defined in the `.env` file
* the admin password stored in the secrets folder

---

## Credentials Management

All sensitive credentials are stored in the `secrets/` directory:

* db_password.txt
* db_root_password.txt
* db_admin_password.txt
* wp_admin_password.txt
* wp_user_password.txt

These files contain:

* database passwords
* WordPress admin password
* WordPress user password

To modify credentials:

* edit the corresponding file in the `secrets/` directory
* restart the project to apply changes

---

## Check Services Status

To verify that services are running:

```bash
make status
```

To view logs:

```bash
make logs
```

To inspect running containers:

```bash
docker ps
```

To access a container shell:

```bash
make gtm   # MariaDB container
make giw   # WordPress container
make gin   # NGINX container
```

---

## Expected Behavior

* NGINX listens on port 443 and serves HTTPS traffic
* WordPress handles PHP requests through PHP-FPM
* MariaDB stores persistent data
* The website should load correctly in a browser
* The admin panel should allow login and content management

If any service is not working:

* check logs
* ensure containers are running
* verify credentials are correct
