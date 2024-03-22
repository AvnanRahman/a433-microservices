# menggunakan image Node.js versi 21 (Alpine Linux)
FROM node:21-alpine

# menentukan working directory ke /app
WORKDIR /app

# menyalin source code ke working directory
COPY . .

# menginstal dependencies yang ada di package*.json
RUN npm install

# Expose port 3001 sesuai ENV
EXPOSE 3001

# menjalankan nodejs
CMD ["npm", "start"]