import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { createRouter, RouterProvider } from '@tanstack/react-router'

import { ThemeProvider } from '@/components/providers/theme-provider'
import { routeTree } from '@/routeTree.gen'

import './styles/global.css'

const router = createRouter({ routeTree, context: { auth: { isAuthenticated: false } } })

declare module '@tanstack/react-router' {
  interface Register {
    router: typeof router
  }
}
const queryClient = new QueryClient()

export default function App() {
  return (
    <ThemeProvider defaultTheme="dark" storageKey="vite-ui-theme">
      <QueryClientProvider client={queryClient}>
        <RouterProvider router={router} context={{ auth: { isAuthenticated: true } }} />
      </QueryClientProvider>
    </ThemeProvider>
  )
}
