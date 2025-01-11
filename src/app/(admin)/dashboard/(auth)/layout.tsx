import { getUser } from "@/lib/auth";
import { redirect } from "next/navigation";

export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const { session, user } = await getUser();

  if (session && user?.role === "superadmin") {
    return redirect("/dashboard");
  }

  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
