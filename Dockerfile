# Step 1: Use a Node.js image to install dependencies and build the app
FROM node:16 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the React application
RUN npm run build

# Step 2: Serve the built React app using a lightweight server
FROM nginx:alpine

# Copy the build output from the previous step to the NGINX directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to be able to access the app from outside the container
EXPOSE 80

# Run the Nginx server to serve the app
CMD ["nginx", "-g", "daemon off;"]
