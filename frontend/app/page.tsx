"use client";

import { useEffect, useState } from "react";
import { apiFetch } from "@/lib/api";
import CompactKPICard from "@/components/dashboard/CompactKPICard";
import ChartCard from "@/components/dashboard/ChartCard";
import DashboardGrid from "@/components/dashboard/DashboardGrid";

export default function Dashboard() {
  const [loading, setLoading] = useState(true);
  const [kpis, setKpis] = useState<any>(null);
  const [topPerformers, setTopPerformers] = useState<any[]>([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const [kpisData, performersData] = await Promise.all([
          apiFetch("/v1/analytics/dashboard-kpis"),
          apiFetch("/v1/analytics/top-performers?limit=10"),
        ]);
        setKpis(kpisData);
        setTopPerformers(performersData);
      } catch (error) {
        console.error("Failed to fetch dashboard data:", error);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);

  if (loading) {
    return (
      <div className="text-center py-20">
        <div className="text-2xl font-bold qt-accent animate-pulse">
          Loading QuikTrip Intelligence...
        </div>
      </div>
    );
  }

  if (!kpis) {
    return (
      <div className="text-center py-20">
        <div className="text-xl text-gray-600">
          Unable to load dashboard data. Please check API connection.
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen">
      <div className="max-w-7xl mx-auto px-6 py-8">
        <div className="mb-8">
          <h1 className="text-4xl font-bold qt-accent">
            QuikTrip Expansion Intelligence
          </h1>
          <p className="text-gray-600 mt-2 text-lg">
            Powered by SAP Business Data Cloud + AI
          </p>
        </div>

        {/* KPI Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
          <CompactKPICard
            icon="🏪"
            value={kpis.total_stores.toLocaleString()}
            label="Active Stores"
            status="neutral"
          />
          <CompactKPICard
            icon="📍"
            value={kpis.candidates_in_pipeline}
            label="Expansion Pipeline"
            status="success"
          />
          <CompactKPICard
            icon="⭐"
            value={kpis.avg_candidate_score.toFixed(1)}
            label="Avg Site Score"
            status={kpis.avg_candidate_score > 75 ? "success" : kpis.avg_candidate_score > 60 ? "warning" : "danger"}
          />
          <CompactKPICard
            icon="💰"
            value={`$${(kpis.projected_new_revenue / 1000000).toFixed(1)}M`}
            label="Projected New Revenue"
            status="success"
          />
        </div>

        {/* Charts */}
        <DashboardGrid cols={1} rows={1} gap={4}>
          <ChartCard title="Top Performing Stores (Last 12 Months)" height="comfortable">
            <div className="space-y-2">
              {topPerformers.map((store, idx) => (
                <div
                  key={store.store_id}
                  className="flex items-center justify-between p-4 bg-gray-50 rounded-lg hover:shadow-md transition"
                >
                  <div className="flex items-center gap-4">
                    <span className="font-bold text-2xl qt-accent">
                      #{idx + 1}
                    </span>
                    <div>
                      <div className="font-semibold text-lg">{store.store_name}</div>
                      <div className="text-sm text-gray-600">
                        {store.city}, {store.state}
                      </div>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="font-bold text-xl">
                      ${(store.avg_revenue / 1000).toFixed(0)}K
                    </div>
                    <div className="text-sm text-green-600 font-medium">
                      {store.avg_margin.toFixed(1)}% margin
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </ChartCard>
        </DashboardGrid>

        <div className="mt-8 bg-white rounded-xl shadow-lg p-6">
          <h2 className="text-2xl font-bold mb-4 qt-accent">Quick Actions</h2>
          <div className="flex gap-4">
            <a href="/candidates" className="qt-btn-primary">
              View Candidate Sites
            </a>
            <a href="/stores" className="qt-btn-secondary">
              View All Stores
            </a>
          </div>
        </div>
      </div>
    </div>
  );
}
