#Menggunakan Image Node JS 14
FROM node:14
#Create Workdir /app di container
WORKDIR /app
#Copy all file to Container
COPY . .
#Set ENV
ENV NODE_ENV=production DB_HOST=item-db
#Install dependencies untuk production dan kemudian build aplikasi
RUN npm install --production --unsafe-perm && npm run build
#Expose port 8080
EXPOSE 8080
#Start NPM
CMD ["npm", "start"]
