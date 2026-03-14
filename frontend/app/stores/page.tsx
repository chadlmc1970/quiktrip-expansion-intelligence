"use client";

import { useEffect, useState } from "react";
import { apiFetch } from "@/lib/api";

export default function StoresPage() {
  const [stores, setStores] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchStores = async () => {
      try {
        const data = await apiFetch("/v1/analytics/stores?limit=50");
        setStores(data);
      } catch (error) {
        console.error("Failed to fetch stores:", error);
      } finally {
        setLoading(false);
      }
    };
    fetchStores();
  }, []);

  if (loading) return <div className="text-center py-20 text-xl qt-accent">Loading stores...</div>;

  return (
    <div className="max-w-7xl mx-auto px-6 py-8">
      <h1 className="text-4xl font-bold mb-2 qt-accent">QuikTrip Stores</h1>
      <p className="text-gray-600 mb-8 text-lg">
        {stores.length} active locations nationwide
      </p>

      <div className="grid gap-4 md:grid-cols-2">
        {stores.map((store) => (
          <div
            key={store.store_id}
            className="bg-white rounded-lg shadow-md p-5 hover:shadow-lg transition"
          >
            <div className="flex items-start justify-between">
              <div>
                <h3 className="text-lg font-bold">{store.store_name}</h3>
                <p className="text-gray-600 text-sm">
                  {store.city}, {store.state}
                </p>
                <p className="text-xs text-gray-500 mt-1 capitalize">
                  {store.store_type} location
                </p>
              </div>
              <span className="text-2xl qt-accent font-bold">{store.store_id}</span>
            </div>

            <div className="grid grid-cols-3 gap-3 mt-4 text-sm">
              <div>
                <div className="text-gray-600 text-xs">Population</div>
                <div className="font-semibold">{(store.population_5mi / 1000).toFixed(0)}K</div>
              </div>
              <div>
                <div className="text-gray-600 text-xs">Median Income</div>
                <div className="font-semibold">${(store.median_income_5mi / 1000).toFixed(0)}K</div>
              </div>
              <div>
                <div className="text-gray-600 text-xs">Daily Traffic</div>
                <div className="font-semibold">{(store.avg_daily_traffic / 1000).toFixed(1)}K</div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
