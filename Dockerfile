# Base image
FROM pytorch/pytorch:2.10.0-cuda12.8-cudnn9-runtime

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --break-system-packages -r requirements.txt

# Download pre-trained models
ENV TORCH_HOME=/opt/torch_models
RUN python -c "from torchvision.models import resnet50, ResNet50_Weights; resnet50(weights=ResNet50_Weights.DEFAULT)"

# Expose the Jupyter port
EXPOSE 8888

# streamlit port
EXPOSE 8501

# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''"]
