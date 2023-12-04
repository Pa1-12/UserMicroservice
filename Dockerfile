FROM python:3.9-slim-buster

WORKDIR /app

# Install PostgreSQL development dependencies
RUN apt-get update \
    && apt-get install -y libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt separately to leverage Docker cache
COPY ./requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . /app

EXPOSE 5000

ENV FLASK_APP=userOperation.py

CMD ["flask", "run", "--host", "0.0.0.0"]
