import { queryOptions, useQuery } from '@tanstack/react-query'

import { api } from '@/data/api/internal/fetcher'
import { authKeys } from '../keys'

import type { User } from '@/data/api/internal/types'

const SESSION_CACHE_TIME = 1000 * 60
const MAXIMUM_RETRIES = 2

export function useGetSessionQuery() {
  return useQuery(getSessionQueryOptions())
}

export const getSessionQueryOptions = () =>
  queryOptions({
    ...authKeys.session,
    queryFn: getSession,
    staleTime: SESSION_CACHE_TIME,
    retry(failureCount, error) {
      if (error instanceof Error && 'status' in error) {
        const status = (error as { status: number }).status

        if (status >= 400 && status < 500) return false
      }

      return failureCount < MAXIMUM_RETRIES
    },
  })

async function getSession(): Promise<User | null> {
  const response = await api.get<User>('/session')

  return response.data
}
