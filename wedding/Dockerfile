# Use a specific and stable version of NGINX Alpine image
FROM public.ecr.aws/nginx/nginx:1.23.3-alpine

# Remove default NGINX website
RUN rm -rf /usr/share/nginx/html/*

# Copy static files to NGINX html folder
COPY . /usr/share/nginx/html

# Copy custom NGINX configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
