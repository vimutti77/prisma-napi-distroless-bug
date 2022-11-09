const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

prisma.user.count().then((count) => {
  console.log(`count: ${count}`);
});
