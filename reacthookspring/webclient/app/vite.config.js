import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig(({ command }) => {
    if (command === "serve") {
        return {
            plugins: [react()],
            base: "/shopapp/",
            server: {
                proxy: {
                    "/shopapp/api": "http://localhost:8081"
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