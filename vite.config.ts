import path from 'node:path'

import tailwindcss from '@tailwindcss/vite'
import { tanstackRouter } from '@tanstack/router-plugin/vite'
import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'
import checker from 'vite-plugin-checker'
import RubyPlugin from 'vite-plugin-ruby'
import svgr from 'vite-plugin-svgr'

export default defineConfig({
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'app/frontend/src'),
    },
  },
  plugins: [
    RubyPlugin(),
    tailwindcss(),
    tanstackRouter({
      target: 'react',
      autoCodeSplitting: true,
    }),
    react({ babel: { plugins: ['babel-plugin-react-compiler'] } }),
    svgr(),
    checker({ typescript: true }),
  ],
})
