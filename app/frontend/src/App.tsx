import { createRouter, RouterProvider } from '@tanstack/react-router'

import { routeTree } from '@/routeTree.gen'

const router = createRouter({ routeTree, context: { auth: { isAuthenticated: false } } })

declare module '@tanstack/react-router' {
  interface Register {
    router: typeof router
  }
}

export default function App() {
  return <RouterProvider router={router} context={{ auth: { isAuthenticated: true } }} />
}
