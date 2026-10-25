# Use the official Python image as the base image
FROM python:3.8

# Set the working directory within the container
WORKDIR /src

# Copy the application code into the container
COPY /src .


RUN pip install -r /src/requirements.txt

# Expose port 8000 to the host
EXPOSE 8000

# Define the command to run the application
ENTRYPOINT [ "sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

