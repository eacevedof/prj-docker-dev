# https://hub.docker.com/_/mariadb
# 12.3: misma versión que cont-mariadb-univ del VPS (prj-docker-infra)
FROM mariadb:12.3

RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    jq vim wget unzip ca-certificates procps curl git \
    && rm -rf /var/lib/apt/lists/*

# https://duckdb.org/docs/guides/file_formats/excel_import.html
RUN wget https://github.com/duckdb/duckdb/releases/download/v1.0.0/duckdb_cli-linux-amd64.zip -O /tmp/duckdb_cli.zip \
    && mkdir -p /duckdb \
    && unzip /tmp/duckdb_cli.zip -d /duckdb \
    && rm /tmp/duckdb_cli.zip \
    && mv /duckdb/duckdb /duckdb/duckdb-cli

RUN chmod -R 777 /tmp

# config propia: la imagen incluye /etc/mysql/conf.d/
RUN printf '%s\n' \
    "[mariadbd]" \
    "# MyISAM recovery settings" \
    "myisam-recover-options=BACKUP,FORCE" \
    "key_buffer_size=256M" \
    "myisam_sort_buffer_size=64M" \
    "" \
    "# General stability" \
    "innodb_flush_log_at_trx_commit=2" \
    "innodb_buffer_pool_size=1024M" \
    "innodb_online_alter_log_max_size=1073741824" \
    "" \
    "# Network and timeouts" \
    "net_read_timeout=600" \
    "net_write_timeout=600" \
    "wait_timeout=3600" \
    "interactive_timeout=3600" \
    "max_allowed_packet=128M" \
    "" \
    "# Memory and disk management" \
    "tmpdir=/tmp" \
    "tmp_table_size=64M" \
    "max_heap_table_size=64M" \
    "sort_buffer_size=8M" \
    "secure_file_priv=/tmp" \
    "" \
    "# Binary logging for CDC (disabled)" \
    "# server-id=1" \
    "# log-bin=mysql-bin" \
    "# binlog_format=ROW" \
    "# max_binlog_size=100M" \
    "# binlog_expire_logs_seconds=86400" \
    "skip-log-bin" \
    > /etc/mysql/conf.d/custom.cnf

COPY ./.bashrc /root/.bashrc

RUN mkdir /app_shared && chmod -R 777 /app_shared
