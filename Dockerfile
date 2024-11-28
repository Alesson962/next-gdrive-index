# Stage 1: Build
FROM node:18-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy the source code and build the Next.js app
COPY . .
RUN npm run build

# Stage 2: Serve
FROM node:18-alpine

WORKDIR /app

# Copy only the necessary artifacts from the build stage
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/static ./.next/static

# Expose the application's port
EXPOSE 3000

# Set the environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Start the app
CMD ["node", "server.js"]
