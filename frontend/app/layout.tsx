import type { Metadata } from "next";
import Nav from "@/components/Nav";
import "./globals.css";

export const metadata: Metadata = {
  title: "QuikTrip Expansion Intelligence | Powered by SAP BDC + AI",
  description: "AI-powered store expansion analytics and site selection intelligence for QuikTrip",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="bg-slate-50 min-h-screen">
        <Nav />
        <main>{children}</main>
      </body>
    </html>
  );
}
