FROM supabase/postgres:15.8.1.085

COPY init-scripts/ /docker-entrypoint-initdb.d/init-scripts/
COPY migrations/ /docker-entrypoint-initdb.d/migrations/

# Railway volume mount is /var/lib/postgresql/data; PGDATA points to a
# subdirectory so initdb does not see the lost+found directory.
ENV PGDATA=/var/lib/postgresql/data/pgdata

EXPOSE 5432

HEALTHCHECK --interval=10s --timeout=5s --retries=10 \
  CMD pg_isready -U postgres -h localhost -p 5432 || exit 1

# Use the upstream supabase/postgres entrypoint and CMD; do not override.
