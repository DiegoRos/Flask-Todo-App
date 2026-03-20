# Flask TODO Application

A simple, containerized task management application built with Flask and MongoDB. This project demonstrates CRUD operations and is configured for deployment in both local environments and Kubernetes clusters.

## Features

- **Task Management:** Create, view, update, delete, and search for tasks.
- **Completion Tracking:** Mark tasks as completed or uncompleted.
- **Persistent Storage:** Uses MongoDB for data persistence.
- **Containerized:** Dockerized for consistent development and deployment.
- **Kubernetes Ready:** Includes manifests for deployment to a cluster (e.g., AWS EKS).
- **Health Monitoring:** Built-in `/health` endpoint for liveness and readiness probes.

## Prerequisites

- Python 3.9+
- MongoDB (running on port 27017)
- [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) (optional, for containerized local run)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/) (optional, for Kubernetes deployment)

## Getting Started

### Local Setup (Manual)

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/DiegoRos/Flask-Todo-App
    cd app_files
    ```

2.  **Install dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

3.  **Run the application:**
    ```bash
    python app.py
    ```
    The application will be accessible at `http://localhost:5000`.

### Local Setup (Docker Compose)

The easiest way to run the full stack (Flask + MongoDB) locally:
```bash
docker-compose up --build
```

## Kubernetes Deployment

The `k8s/` directory contains manifests for deploying the application with persistent storage:

NOTE: If you wish to deploy on locally palace a comment on the `storageClassName` in the k8s/mongo-setup.yaml and skip step 1. 

1.  **Storage Class:** `kubectl apply -f k8s/sc.yaml`
2.  **MongoDB:** `kubectl apply -f k8s/mongo-setup.yaml`
3.  **Flask Application:** `kubectl apply -f k8s/flask-app-setup.yaml`
4.  **Monitoring and Alerting using Helm**: `helm upgrade prometheus prometheus-community/kube-prometheus-stack -f k8s/alert-config.yaml`


## Monitoring & Alerting

The project includes pre-configured monitoring and alerting via Prometheus and Alertmanager (see `k8s/alert-config.yaml`):

- **Notifications:** Alerts are configured to be sent to a dedicated Slack channel (`#alerts`).
- **Custom Alert Rules:**
  - **FlaskAppPodMissing (Critical):** Triggers if the Flask app pod is missing or not in a `Running` state for more than 1 minute.
  - **HighProbeFailureRate (Warning):** Triggers if pods are restarting continuously, indicating failed liveness or readiness probes.
- **Noise Reduction:** The `Watchdog` heartbeat alert is suppressed to prevent notification spam.

## Configuration

The application can be configured via environment variables:
- `MONGO_HOST`: Hostname for MongoDB (default: `localhost`).
- `MONGO_PORT`: Port for MongoDB (default: `27017`).
- `FLASK_ENV`: Set to `production` or `development`.
- `PORT`: Port for the Flask application (default: `5000`).

## Project Structure

- `app.py`: Main application logic and routes.
- `k8s/`: Kubernetes manifest files.
- `static/`: Static assets (CSS, JS, Images).
- `templates/`: HTML templates for the UI.
- `Dockerfile` & `docker-compose.yaml`: Containerization configuration.
