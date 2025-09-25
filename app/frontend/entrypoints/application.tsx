import React from 'react'
import { createRoot, type Root } from 'react-dom/client'

import App from '../src/App'

let root: Root | null = null

function mount() {
  const el = document.getElementById('root')
  if (!el) return
  if (el.dataset['mounted'] === 'true') return

  root = createRoot(el)
  root.render(
    <React.StrictMode>
      <App />
    </React.StrictMode>,
  )
  el.dataset['mounted'] = 'true'
}

function unmount() {
  const el = document.getElementById('root')
  if (root && el) {
    root.unmount()
    delete el.dataset['mounted']
    root = null
  }
}

document.addEventListener('DOMContentLoaded', mount)
document.addEventListener('turbo:load', mount)
document.addEventListener('turbo:before-render', unmount)

if (import.meta.hot) {
  import.meta.hot.accept()
  import.meta.hot.dispose(unmount)
}
