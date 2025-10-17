FROM python:3.11-slim

# Install system dependencies for Playwright and Firefox
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    libgtk-3-0 \
    libdbus-glib-1-2 \
    libxt6 \
    libsm6 \
    libice6 \
    libasound2 \
    fonts-liberation \
    libnss3 \
    libxss1 \
    xdg-utils \
    libgbm1 \
    libxshmfence1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright browsers
RUN python -m playwright install firefox
RUN python -m playwright install-deps firefox

# Copy application code
COPY worker.py .

# Expose port
EXPOSE 10000

# Run the application
CMD ["python", "worker.py"]
