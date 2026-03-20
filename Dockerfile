# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Set environment variables
ENV FLASK_ENV=production
ENV MONGO_HOST=mongodb-service
ENV PORT=5000

# Expose port 5000 for the Flask application
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]