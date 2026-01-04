# React DevOps Deployment – CI/CD Pipeline

## 📌 Project Overview

This project demonstrates a **production-ready deployment** of a React e-commerce application using **Docker, Jenkins, AWS EC2, and monitoring**.

The complete CI/CD pipeline automatically:

* Builds Docker images
* Pushes images to Docker Hub (DEV / PROD)
* Deploys the application to AWS EC2
* Monitors application health

---

## 🧱 Tech Stack

* **Frontend**: ReactJS
* **CI/CD**: Jenkins
* **Containerization**: Docker, Docker Compose
* **Cloud**: AWS EC2 (t2.micro)
* **Registry**: Docker Hub
* **Monitoring**: Cron + Shell Script
* **OS**: Amazon Linux 2

---

## 🌿 Branch Strategy

| Branch            | Purpose                                    |
| ----------------- | ------------------------------------------ |
| `dev`             | Development & CI build                     |
| `master` / `main` | Production release (optional future merge) |

> ℹ️ Currently the project runs from the **dev branch**, as required.

---

## 🐳 Docker Hub Repositories

| Environment | Repository                    | Visibility |
| ----------- | ----------------------------- | ---------- |
| DEV         | `bhavadesh/react-devops-dev`  | Public     |
| PROD        | `bhavadesh/react-devops-prod` | Private    |

---

## 📁 Project Structure

```
.
├── Dockerfile
├── docker-compose.yml
├── Jenkinsfile
├── build.sh
├── deploy.sh
├── .dockerignore
├── .gitignore
├── build/
└── README.md
```

---

## 🐳 Docker Configuration

### Dockerfile

* Uses **nginx:alpine**
* Serves React build from `/usr/share/nginx/html`
* Optimized for production

### docker-compose.yml

* Exposes application on **port 80**
* Runs container in detached mode

---

## 🧪 Bash Scripts

### build.sh

Builds the Docker image:

```bash
docker build -t react-app .
```

### deploy.sh

Deploys application using Docker Compose:

```bash
docker-compose down || true
docker-compose up -d
```

---

## ⚙️ Jenkins CI/CD Pipeline

### Jenkinsfile Features

* Git checkout
* Docker build
* Docker Hub login (token-based)
* Branch-based image push:

  * `dev` → DEV Docker repo
  * `master/main` → PROD Docker repo
* Application deployment
* Post-build cleanup

---

## ☁️ AWS EC2 Setup

* Instance type: **t2.micro**
* OS: Amazon Linux 2
* Open ports:

  * **80** → Application
  * **8080** → Jenkins
  * **22** → SSH (restricted IP)

---

## 🌐 Live Application

🔗 **Deployed URL**

```
http://13.127.43.55
```

---

## 📊 Monitoring Setup

### Health Check Script

A shell script checks application health every minute.

**Path**

```
/opt/app_health_check.sh
```

**Logic**

* Sends HTTP request
* Logs status to `/var/log/app_health.log`
* Cron runs every minute

### Cron Job

```bash
* * * * * /opt/app_health_check.sh
```

---

## 📸 Screenshots Included

* Jenkins configuration & builds
* AWS EC2 & Security Groups
* Docker Hub image tags
* Deployed website
* Monitoring logs

> Full screenshots are linked inside the project documentation.

---

## ✅ Project Status

✔ Dockerized
✔ CI/CD Implemented
✔ AWS Deployed
✔ Monitoring Enabled
✔ Production Ready

---

## 👤 Author

**Bhavadesh Arul**
DevOps & Cloud Enthusiast

---
