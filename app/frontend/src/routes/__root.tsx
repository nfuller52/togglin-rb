import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import {
  createRootRouteWithContext,
  HeadContent,
  Outlet,
  useRouteContext,
} from '@tanstack/react-router'

import { ThemeProvider } from '@/providers/theme-provider'
import globalCss from '@/styles/global.css?url'

export interface RouterContext {
  queryClient: QueryClient
}

function RootLayout() {
  const { queryClient } = useRouteContext({ from: '__root__' })

  return (
    <ThemeProvider defaultTheme="dark">
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
