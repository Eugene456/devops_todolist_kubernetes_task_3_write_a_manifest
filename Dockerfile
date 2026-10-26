# Use the official Python image as the base image
FROM python:3.8

# Set the working directory within the container
WORKDIR /src

# Install dependencies first to leverage Docker layer caching
COPY /src/requirements.txt .
RUN pip install -r requirements.txt

# Copy the rest of the application code into the container
COPY /src .

# Expose port 8000 to the host
EXPOSE 8000

# Define the command to run the application
ENTRYPOINT [ "sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

