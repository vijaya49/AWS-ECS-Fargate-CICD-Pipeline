#with root user
FROM public.ecr.aws/docker/library/python:3.11
# Set working directory inside the container
WORKDIR /app
# Copy only the app folder content into the container
COPY . .
# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
# Ensure the start script is executable
RUN chmod +x start.sh
# Expose port 80 for the container
EXPOSE 80
# Start the app using the start script
CMD ["./start.sh"]

#non-root-user
# FROM public.ecr.aws/docker/library/python:3.11
# RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
# WORKDIR /app
# COPY . /app
# RUN pip install --no-cache-dir -r requirements.txt
# RUN chmod +x /app/start.sh && \
#     chown -R appuser:appgroup /app
# USER appuser
# EXPOSE 8080
# CMD ["/app/start.sh"]
