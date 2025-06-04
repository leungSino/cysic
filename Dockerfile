# ========= Stage 1: 下载 verifier 和依赖 =========
FROM ubuntu:22.04 AS dl

WORKDIR /app

RUN apt-get update && apt-get install -y curl ca-certificates

RUN curl -L https://github.com/cysic-labs/cysic-phase3/releases/download/v1.0.0/verifier_linux -o verifier \
    && chmod +x ./verifier

RUN curl -L https://github.com/cysic-labs/cysic-phase3/releases/download/v1.0.0/libdarwin_verifier.so -o libdarwin_verifier.so

RUN curl -L https://github.com/cysic-labs/cysic-phase3/releases/download/v1.0.0/librsp.so -o librsp.so

COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh
COPY config.yaml /app/


# ========= Stage 2: 构建最终镜像 =========
FROM ubuntu:22.04 AS final

WORKDIR /app

COPY --from=dl /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=dl /app/ /app/

ENV LD_LIBRARY_PATH=/app
ENV CHAIN_ID=534352

ENTRYPOINT ["/app/entrypoint.sh", "/app/verifier"]
