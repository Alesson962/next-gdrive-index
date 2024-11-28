# Base image for Node.js
FROM node:18-alpine

# Set work directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the project files
COPY . .

# Build the Next.js app
RUN npm run build

# Expose the default Next.js port
EXPOSE 3000

# Specify the NODE_ENV environment variable
ENV NODE_ENV=production

# Start the Next.js app
CMD ["npm", "run", "start"]
