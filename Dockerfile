########## deps ##########
FROM node:18.12.1-bullseye-slim as deps

# set working directory
WORKDIR /app/

# install dependencies
COPY package.json package-lock.json /app/
RUN npm ci

# generate prisma models
COPY prisma /app/prisma
RUN npx prisma generate

########## final ##########
FROM gcr.io/distroless/nodejs18-debian11:debug

# set working directory
WORKDIR /app/

# copy node_modules
COPY --from=deps /app/node_modules/ /app/node_modules/

# copy db & script
COPY prisma /app/prisma
COPY index.js /app/index.js

CMD ["/app/index.js"]
