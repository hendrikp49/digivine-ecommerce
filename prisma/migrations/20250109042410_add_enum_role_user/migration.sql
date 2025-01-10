/*
  Warnings:

  - The values [stock] on the enum `ProductStock` will be removed. If these variants are still used in the database, this will fail.
  - Changed the type of `status` on the `Order` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "RoleUser" AS ENUM ('superadmin', 'customer');

-- CreateEnum
CREATE TYPE "StatusOrder" AS ENUM ('pending', 'success', 'failed');

-- AlterEnum
BEGIN;
CREATE TYPE "ProductStock_new" AS ENUM ('ready', 'preorder');
ALTER TABLE "Product" ALTER COLUMN "stock" TYPE "ProductStock_new" USING ("stock"::text::"ProductStock_new");
ALTER TYPE "ProductStock" RENAME TO "ProductStock_old";
ALTER TYPE "ProductStock_new" RENAME TO "ProductStock";
DROP TYPE "ProductStock_old";
COMMIT;

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "status",
ADD COLUMN     "status" "StatusOrder" NOT NULL;

-- AlterTable
ALTER TABLE "OrderDetail" ALTER COLUMN "notes" DROP NOT NULL;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "role" "RoleUser" NOT NULL DEFAULT 'customer';

-- DropEnum
DROP TYPE "Status_Order";
