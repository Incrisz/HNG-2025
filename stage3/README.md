# Backend Infrastructure Setup Guide

This guide provides step-by-step instructions for setting up the backend infrastructure, including K3s (lightweight Kubernetes), Go, and Python dependencies.

---

## **1. System Update & Upgrade**
Update and upgrade the system packages to ensure you have the latest versions.
```sh
sudo apt update && sudo apt upgrade -y
```

---

## **2. Install K3s (Lightweight Kubernetes)**
### **Step 1: Install K3s**
```sh
curl -sfL https://get.k3s.io | sh -
```

### **Step 2: Verify K3s Installation**
```sh
k3s --version
```

### **Step 3: Enable and Start K3s Service**
```sh
sudo systemctl enable --now k3s
```

### **Step 4: Configure K3s**
```sh
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

### **Step 5: Verify K3s Cluster**
```sh
kubectl get nodes
```

---

## **3. Install Kubectl (Kubernetes CLI)**
Download and install the latest stable version of `kubectl`.
```sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

Verify the installation:
```sh
kubectl version --client
```

---

## **4. Install Python & Pip**
### **Step 1: Install Python & Pip**
```sh
sudo apt install python3-pip -y
```

### **Step 2: Verify Python Version**
```sh
python3 --version
```



---

## **5. Install Go (Golang) 1.22**
### **Step 1: Remove Old Go Version**
```sh
sudo rm -rf /usr/local/go
```

### **Step 2: Download & Install Go 1.22**
```sh
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
rm go1.22.0.linux-amd64.tar.gz
```

### **Step 3: Add Go to PATH**
```sh
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
```

### **Step 4: Verify Go Installation**
```sh
go version
```

---

## **6. Clone the Backend Repository**
Clone the backend repository from GitHub and navigate into the project directory.
```sh
git clone https://github.com/obiMadu/backend.im-infra
cd backend.im-infra
```

---

## **7. Set Up Python Virtual Environment & Install Dependencies**
### **Step 1: Install Virtual Environment Support**
```sh
sudo apt install python3.12-venv -y
```

### **Step 2: Create and Activate Virtual Environment**
```sh
python3 -m venv .venv
source .venv/bin/activate
```

### **Step 3: Install Required Dependencies**
```sh
pip install -r app/requirements.txt
```

---

## **8. Start the FastAPI Server**
Navigate to the application directory and run the FastAPI server.
```sh
cd app
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

Your FastAPI application should now be running and accessible at `http://0.0.0.0:8000/`.

