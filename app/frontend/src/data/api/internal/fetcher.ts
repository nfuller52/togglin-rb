import axios from 'axios'

import { InternalApiException } from './errors'

import type { InternalApiError } from './errors'
import type { AxiosError } from 'axios'

function getCsrfToken() {
  const meta = document.querySelector('meta[name="csrf-token"]')
  return meta ? meta.getAttribute('content') : null
}

export const api = axios.create({
  baseURL: '/api/internal',
  timeout: 10000,
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
  (error: AxiosError<InternalApiError>) => {
    const { data } = error.response || {}

    const apiError = new InternalApiException(
      data?.message || error.message || 'An unknown error occurred',
      error.response?.status || 500,
      data?.errors,
    )

    return Promise.reject(apiError)
  },
)
