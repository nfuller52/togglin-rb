import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { createRootRouteWithContext, HeadContent, Outlet } from '@tanstack/react-router'

import { ThemeProvider } from '@/components/providers/theme-provider'
import globalCss from '@/styles/global.css?url'

export interface RouterContext {
  auth: { isAuthenticated: boolean }
}

const queryClient = new QueryClient()

function RootLayout() {
  return (
    <ThemeProvider defaultTheme="dark" storageKey="vite-ui-theme">
      <QueryClientProvider client={queryClient}>
        <HeadContent />
        <Outlet />
      </QueryClientProvider>
    </ThemeProvider>
  )
}

export const Route = createRootRouteWithContext<RouterContext>()({
  head: () => ({
    links: [{ rel: 'stylesheet', href: globalCss }],
  }),
  component: RootLayout,
})
