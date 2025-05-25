# 🚀 FastAPI Docker + ECR + GitHub Actions

This project demonstrates how to:

- Build and test an asynchronous API using **FastAPI** and **Pytest**  
- **Dockerize** the application  
- **Automate Docker image builds** and **pushes to AWS ECR** using **GitHub Actions**  
- Tag the Docker image based on the Git branch:  
  - `develop` → tagged as `develop`  
  - `main` → tagged as `latest`

---

## 👨‍🏫 Want to Learn How This Works?

Check out the full blog post here 👉 [**FastAPI Docker + ECR + ECS Deployment Guide**](https://medium.com/@naveen30111/8d38e04d81dc)

---

## ⚙️ Want to Use This Project Locally?

### 🐳 Run with Docker Compose

To spin up the FastAPI app locally using Docker:

```bash
docker-compose up -d --build
