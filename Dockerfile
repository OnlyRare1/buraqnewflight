# Use an official lightweight Python image
FROM python:3.9-slim

# Install system dependencies for Chrome and Selenium
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    chromium \
    chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for Chrome
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_PATH=/usr/bin/chromedriver

# Set up the app directory
WORKDIR /app

# Copy requirement file and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code
COPY . .

# Expose port 5000 for the Flask server
EXPOSE 5000

# Start the application using Gunicorn (Production Server)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "main:app"]