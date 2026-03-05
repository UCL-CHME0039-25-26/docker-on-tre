# CHME0039 – Docker on a Trusted Research Environment (TRE)

This repository is used in the **CHME0039 Docker/TRE workshop** to demonstrate how to:

- Build and run a **PyTorch + Jupyter** environment locally
- Package **both source code and Docker images**
- Transfer and run the same environment inside an **air-gapped Trusted Research Environment (TRE)**

The key learning goal is understanding how Docker enables **reproducible research workflows** even when **no internet access** is available.

---

## Prerequisites (Local Machine)

Before starting, ensure you have:

- Docker Engine (≥ 20.x)
- Docker Compose v2
- Git
- A working internet connection (local machine only)

Check Docker is working:

```bash
docker --version
docker compose version
```

---

## Part 1 — Working on Your Local Machine (Internet Enabled)

These steps are performed **on your own laptop/workstation**.

### 1. Clone the repository

```bash
git clone https://github.com/UCL-CHME0039-25-26/docker-on-tre.git
cd docker-on-tre
```

---

### 2. Build the Docker image

This builds the PyTorch image **once**, including downloading pretrained model weights.

```bash
docker compose build
```

---

### 3. Start the container

```bash
docker compose up -d
```

---

### 4. Access the running container

You can work **either** via a shell **or** Jupyter.

#### Option A — Shell access

```bash
docker exec -it pytorch-basic-container bash
```

#### Option B — Jupyter Lab

Open a browser and go to:

```
http://localhost:8888
```

---

### 5. Verify pretrained model availability

Inside the container:

```bash
ls -lh /opt/torch_models/hub/checkpoints/
```

Expected output:

```text
total 98M
-rw-r--r-- 1 root root 98M Jan 22 10:55 resnet50-11ad3fa6.pth
```

---

### 6. Run the example inference

```bash
cd examples
python single_image.py
```

---

### 7. Package the repository source code at the host machine

```bash
cd ../../
tar -czvf chme0039-pytorch-basic-repo.tar.gz docker-on-tre
```

---

### 8. Verify the Docker image exists

```bash
docker images
```

---

### 9. Export the Docker image

```bash
docker save -o chme0039-pytorch-basic-v1.4.tar chme0039-pytorch-basic:1.4
```

---

### 10. Download Docker Compose binary (for TRE)

```bash
curl -Lo docker-compose https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64
```

---

## Part 2 — Working in the Remote Air-Gapped TRE

These steps are performed **on [UCL TRE](https://tre.arc.ucl.ac.uk)**.

### 1. Upload files to the TRE

- `chme0039-pytorch-basic-repo.tar.gz`
- `chme0039-pytorch-basic-v1.4.tar`
- `docker-compose`

---

### 2. Open a TRE terminal and prepare workspace (creates a new directory called chme0039, copy ingressed files into the new directory)

```bash
sudo su
cd
mkdir -p chme0039
cp /shared/inbound/<ucl-id>/* chme0039/
cd chme0039
```

---

### 3. Extract and load

```bash
tar -zxvf chme0039-pytorch-basic-repo.tar.gz
docker load -i chme0039-pytorch-basic-v1.4.tar
```

---

### 4. Install Docker Compose locally

```bash
chmod +x docker-compose
mkdir -p ~/.docker/cli-plugins
mv docker-compose ~/.docker/cli-plugins/
```

---

### 5. Start services

```bash
cd docker-on-tre
systemctl start podman
docker compose up -d
```

---

### 6. Access Jupyter

Open Firefox inside the TRE and visit:

```
http://localhost:8888
```

---

### 7. Run example (offline)

```bash
docker exec -it pytorch-basic-container bash
cd examples
python single_image.py
```

---

### 8. GPU enabled run in TRE

```bash
docker run -it --rm --gpus all -v .:/app:Z -v ./data:/app/data:Z chme0039-pytorch-basic:1.4 bash
ipython
```

Inside ipython, run
```ipython
import torch
torch.cuda.is_available()
```

The result should be True for GPU enabled instances where the docker GPU passthrough is working.

---

## Key Takeaways

- Docker enables **reproducible, portable research environments**
- Air-gapped systems require **explicit image and code packaging**
- `docker save` and `docker load` are essential TRE skills

---

End of workshop instructions.
