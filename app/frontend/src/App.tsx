import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { RouterProvider, createRouter } from '@tanstack/react-router'

import { routeTree } from '@/routeTree.gen'

const router = createRouter({ routeTree, context: { auth: { isAuthenticated: false } } })

declare module '@tanstack/react-router' {
  interface Register {
    router: typeof router
  }
}
const queryClient = new QueryClient()

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <RouterProvider router={router} context={{ auth: { isAuthenticated: true } }} />
    </QueryClientProvider>
  )
}
