import { useQuery } from '@tanstack/react-query'

import { api } from '@/data/api/internal/fetcher'
import { authKeys } from '../keys'

import type { User } from '@/data/api/internal/types'

export function useGetSessionQuery() {
  return useQuery({ ...authKeys.session, queryFn: getSession })
}

async function getSession(): Promise<User | null> {
  const response = await api.get<User>('/session')

  return response.data
}
