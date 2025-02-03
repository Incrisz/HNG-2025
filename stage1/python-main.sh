#!/bin/bash

# Exit on error
set -e

# Variables
APP_DIR="/home/ubuntu/number-classifier"
SERVER_IP="18.175.45.20"  # Replace with your server's public IP

# Update system and install dependencies
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3 python3-pip python3-venv nginx git

# Setup virtual environment
echo "Setting up virtual environment..."
mkdir -p "$APP_DIR"
cd "$APP_DIR"
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install flask gunicorn

# Create Flask app
cat <<EOF > "$APP_DIR/app.py"
from flask import Flask, request, jsonify
import math

app = Flask(__name__)

def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0:
            return False
    return True

def is_perfect(n):
    return n == sum(i for i in range(1, n) if n % i == 0)

def is_armstrong(n):
    digits = [int(d) for d in str(n)]
    return n == sum(d ** len(digits) for d in digits)

@app.route("/api/classify-number", methods=["GET"])
def classify_number():
    number = request.args.get("number")
    if not number.isdigit():
        return jsonify({"number": number, "error": True}), 400
    
    num = int(number)
    properties = []
    if is_armstrong(num):
        properties.append("armstrong")
    if num % 2 == 0:
        properties.append("even")
    else:
        properties.append("odd")
    
    return jsonify({
        "number": num,
        "is_prime": is_prime(num),
        "is_perfect": is_perfect(num),
        "properties": properties,
        "digit_sum": sum(int(d) for d in str(num)),
        "fun_fact": f"{num} is an Armstrong number because {'+'.join([f'{d}^{len(str(num))}' for d in map(int, str(num))])} = {num}" if is_armstrong(num) else f"{num} is a fascinating number!"
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
EOF

# Create Gunicorn service
echo "Creating systemd service..."
cat <<EOF | sudo tee /etc/systemd/system/number-classifier.service
[Unit]
Description=Flask Number Classifier
After=network.target

[Service]
User=ubuntu
Group=ubuntu
WorkingDirectory=$APP_DIR
ExecStart=$APP_DIR/venv/bin/gunicorn --workers 4 --bind 0.0.0.0:8000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start service
sudo systemctl daemon-reload
sudo systemctl enable number-classifier
sudo systemctl start number-classifier

# Configure NGINX
echo "Configuring NGINX..."
cat <<EOF | sudo tee /etc/nginx/sites-available/number-classifier
server {
    listen 80;
    server_name $SERVER_IP;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

# Enable NGINX config
sudo ln -s /etc/nginx/sites-available/number-classifier /etc/nginx/sites-enabled/
sudo systemctl restart nginx

# Final status check
echo "Deployment complete!"
echo "Your API is live at: http://$SERVER_IP/api/classify-number?number=371"
sudo systemctl status number-classifier --no-pager
