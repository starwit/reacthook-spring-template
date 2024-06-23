import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig(({ command }) => {
    if (command === "serve") {
        return {
            plugins: [react()],
            base: "/reacthookspring/",
            server: {
                proxy: {
                    "/reacthookspring/api": "http://localhost:8081"
                }
            }
        };
    } else {
        return {
            plugins: [react()],
            base: "./"
        };
    }
});