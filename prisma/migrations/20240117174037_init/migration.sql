/*
  Warnings:

  - You are about to drop the column `userId` on the `Modules` table. All the data in the column will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `student_id` to the `Modules` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Modules" DROP CONSTRAINT "Modules_userId_fkey";

-- AlterTable
ALTER TABLE "Modules" DROP COLUMN "userId",
ADD COLUMN     "student_id" INTEGER NOT NULL,
ALTER COLUMN "joined" SET DEFAULT CURRENT_TIMESTAMP;

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Student" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'BASIC',

    CONSTRAINT "Student_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Books" (
    "book_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "Books_pkey" PRIMARY KEY ("book_id")
);

-- CreateTable
CREATE TABLE "_BooksToStudent" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_BooksToStudent_AB_unique" ON "_BooksToStudent"("A", "B");

-- CreateIndex
CREATE INDEX "_BooksToStudent_B_index" ON "_BooksToStudent"("B");

-- AddForeignKey
ALTER TABLE "Modules" ADD CONSTRAINT "Modules_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "Student"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BooksToStudent" ADD CONSTRAINT "_BooksToStudent_A_fkey" FOREIGN KEY ("A") REFERENCES "Books"("book_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BooksToStudent" ADD CONSTRAINT "_BooksToStudent_B_fkey" FOREIGN KEY ("B") REFERENCES "Student"("id") ON DELETE CASCADE ON UPDATE CASCADE;
