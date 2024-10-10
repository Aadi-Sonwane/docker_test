FROM python:3.11-slim-buster as builder

# Set the workdir to the project directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the project files
COPY . .

# Build the Django project
RUN python manage.py collectstatic --noinput

# Create a new image based on the builder image
FROM python:3.11-slim-buster

# Copy the built project from the builder stage
COPY --from=builder /app /app

# Expose the port your Django app will listen on (e.g., 8000)
EXPOSE 8000

# Set environment variables (replace with your actual values)
ENV DJANGO_SETTINGS_MODULE=your_project.settings

# Command to run your Django app
CMD ["python", "manage.py", "runserver"]