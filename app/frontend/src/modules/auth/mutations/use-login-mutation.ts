import { useMutation } from '@tanstack/react-query'

import { api } from '@/data/api/internal/fetcher'

import type { UserSession } from '@/data/api/internal/types'

export type LoginParams = {
  email: string
  password: string
}

export function useLoginMutation() {
  return useMutation({ mutationFn: login })
}

async function login({ email, password }: LoginParams): Promise<UserSession> {
  const response = await api.post<UserSession>('/session', {
    email,
    password,
  })

  return response.data
}
