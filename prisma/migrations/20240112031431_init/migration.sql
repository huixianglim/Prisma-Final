-- CreateEnum
CREATE TYPE "Role" AS ENUM ('BASIC', 'ADMIN', 'EDITOR');

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "role" "Role" NOT NULL DEFAULT 'BASIC';

-- CreateTable
CREATE TABLE "Modules" (
    "module_int" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "credit" INTEGER NOT NULL,
    "joined" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Modules_pkey" PRIMARY KEY ("module_int")
);

-- AddForeignKey
ALTER TABLE "Modules" ADD CONSTRAINT "Modules_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
