import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import react from '@vitejs/plugin-react'
import tsconfigPaths from 'vite-tsconfig-paths'
import checker from 'vite-plugin-checker'
import svgr from 'vite-plugin-svgr'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    react({ babel: { plugins: ['babel-plugin-react-compiler'] } }),
    tsconfigPaths(),
    svgr(),
    checker({ typescript: true }),
  ],
})
