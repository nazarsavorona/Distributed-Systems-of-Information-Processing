FROM postgres:12

# Install dependencies for pglogical
RUN apt-get update && apt-get install -y \
    postgresql-12-pglogical \
    && rm -rf /var/lib/apt/lists/*

# Add pglogical to shared_preload_libraries
RUN echo "shared_preload_libraries = 'pglogical'" >> /usr/share/postgresql/postgresql2.conf.sample
