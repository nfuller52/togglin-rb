import axios from 'axios'

function getCsrfToken() {
  const meta = document.querySelector('meta[name="csrf-token"]')
  return meta ? meta.getAttribute('content') : null
}

export const api = axios.create({
  baseURL: '/api/internal',
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json',
    Accept: 'application/json',
  },
})

api.interceptors.request.use((config) => {
  const token = getCsrfToken()

  if (token && config.method && config.method.toUpperCase() !== 'GET') {
    config.headers['X-CSRF-Token'] = token
  }

  return config
})

api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      console.warn('Unauthorized! Redirecting to login...')
    }

    return Promise.reject(
      error instanceof Error ? error : new Error(error?.message || String(error)),
    )
  },
)
