FROM debian:bookworm-slim
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]