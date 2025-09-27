import { createRootRouteWithContext, Outlet } from '@tanstack/react-router'

export interface RouterContext {
  auth: { isAuthenticated: boolean }
}

function RootLayout() {
  return <Outlet />
}

export const Route = createRootRouteWithContext<RouterContext>()({ component: RootLayout })
