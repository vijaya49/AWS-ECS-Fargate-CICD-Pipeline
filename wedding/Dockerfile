# Use official NGINX Alpine image
FROM public.ecr.aws/nginx/nginx:latest

# Remove default NGINX website
RUN rm -rf /usr/share/nginx/html/*

# Copy static files to NGINX html folder
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]

#static web hosting##
##
