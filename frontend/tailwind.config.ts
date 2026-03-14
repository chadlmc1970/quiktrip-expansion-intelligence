import type { Config } from "tailwindcss";

export default {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        qt: {
          red: "#E70D30",
          dark: "#323232",
          gray: "#494949",
          light: "#F8F8F8",
        },
      },
    },
  },
  plugins: [],
} satisfies Config;
