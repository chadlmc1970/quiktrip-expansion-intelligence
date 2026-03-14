import Link from "next/link";

export default function Nav() {
  return (
    <nav className="qt-nav shadow-lg">
      <div className="max-w-7xl mx-auto px-6 py-4">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-8">
            <Link href="/" className="text-2xl font-bold qt-accent hover:opacity-80 transition">
              QuikTrip
            </Link>
            <div className="text-sm text-gray-300">
              Expansion Intelligence Platform
            </div>
          </div>

          <div className="flex items-center gap-6">
            <Link href="/" className="hover:text-red-400 transition">
              Dashboard
            </Link>
            <Link href="/stores" className="hover:text-red-400 transition">
              Stores
            </Link>
            <Link href="/candidates" className="hover:text-red-400 transition">
              Candidate Sites
            </Link>
          </div>
        </div>
      </div>
    </nav>
  );
}
