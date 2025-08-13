# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Flask and Gunicorn
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 5000 for the Flask app
EXPOSE 5000

# Command to run the Flask app with Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
