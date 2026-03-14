"use client";

import { useEffect, useState } from "react";
import { apiFetch } from "@/lib/api";

export default function CandidatesPage() {
  const [candidates, setCandidates] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [scoring, setScoring] = useState<string | null>(null);

  useEffect(() => {
    fetchCandidates();
  }, []);

  const fetchCandidates = async () => {
    try {
      const data = await apiFetch("/v1/site-scoring/candidates");
      setCandidates(data);
    } catch (error) {
      console.error("Failed to fetch candidates:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleScoreSite = async (candidateId: string) => {
    setScoring(candidateId);
    try {
      await apiFetch(`/v1/site-scoring/score/${candidateId}`, { method: "POST" });
      await fetchCandidates();
    } catch (error) {
      alert("Failed to score site. Please try again.");
    } finally {
      setScoring(null);
    }
  };

  if (loading) return <div className="text-center py-20 text-xl qt-accent">Loading...</div>;

  return (
    <div className="max-w-7xl mx-auto px-6 py-8">
      <h1 className="text-4xl font-bold mb-2 qt-accent">Candidate Sites</h1>
      <p className="text-gray-600 mb-8 text-lg">
        Strategic expansion opportunities analyzed with AI-powered site scoring
      </p>

      <div className="grid gap-6">
        {candidates.map((site) => {
          const scoreColor =
            site.site_score && site.site_score >= 80
              ? "#10B981"
              : site.site_score && site.site_score >= 60
              ? "#F59E0B"
              : site.site_score
              ? "#EF4444"
              : "#9CA3AF";

          return (
            <div
              key={site.candidate_id}
              className="bg-white rounded-xl shadow-md p-6 border-l-4 hover:shadow-lg transition"
              style={{ borderLeftColor: scoreColor }}
            >
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <h3 className="text-2xl font-bold mb-1">{site.site_name}</h3>
                  <p className="text-gray-600 text-lg mb-3">
                    {site.city}, {site.state} • {site.proposed_type}
                  </p>

                  <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mt-4">
                    <div>
                      <div className="text-sm text-gray-600">Population (5mi)</div>
                      <div className="font-bold">{site.population_5mi?.toLocaleString() || "N/A"}</div>
                    </div>
                    <div>
                      <div className="text-sm text-gray-600">Median Income</div>
                      <div className="font-bold">${(site.median_income_5mi / 1000).toFixed(0)}K</div>
                    </div>
                    <div>
                      <div className="text-sm text-gray-600">Daily Traffic</div>
                      <div className="font-bold">{site.avg_daily_traffic?.toLocaleString() || "N/A"}</div>
                    </div>
                    <div>
                      <div className="text-sm text-gray-600">Total Investment</div>
                      <div className="font-bold">
                        ${((site.land_cost + site.construction_cost) / 1000000).toFixed(2)}M
                      </div>
                    </div>
                  </div>
                </div>

                <div className="text-right ml-6">
                  <div className="text-5xl font-bold qt-accent mb-1">
                    {site.site_score ? site.site_score.toFixed(0) : "—"}
                  </div>
                  <div className="text-sm text-gray-600 mb-4">Site Score</div>

                  {site.predicted_revenue && (
                    <div className="mt-4">
                      <div className="text-sm text-gray-600">Predicted Revenue</div>
                      <div className="font-bold text-lg">
                        ${(site.predicted_revenue / 1000000).toFixed(2)}M/yr
                      </div>
                      <div className="text-xs text-gray-500 mt-1">
                        {site.confidence ? `${(site.confidence * 100).toFixed(0)}% confidence` : ""}
                      </div>
                    </div>
                  )}
                </div>
              </div>

              <div className="mt-6">
                {!site.site_score ? (
                  <button
                    onClick={() => handleScoreSite(site.candidate_id)}
                    disabled={scoring === site.candidate_id}
                    className="qt-btn-primary disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    {scoring === site.candidate_id ? "Scoring with AI..." : "Score This Site"}
                  </button>
                ) : (
                  <button
                    onClick={() => handleScoreSite(site.candidate_id)}
                    disabled={scoring === site.candidate_id}
                    className="qt-btn-secondary disabled:opacity-50"
                  >
                    {scoring === site.candidate_id ? "Re-scoring..." : "Re-score Site"}
                  </button>
                )}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
