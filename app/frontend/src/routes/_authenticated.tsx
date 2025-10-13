import { createFileRoute, Link, Outlet, redirect } from '@tanstack/react-router'

import { InternalApiException } from '@/data/api/internal/errors'
import { getSessionQueryOptions } from '@/modules/auth'

function AuthenticatedRoute() {
  return (
    <>
      <Link to="/" className="[&.active]:font-bold">
        Home
      </Link>
      <Link to="/about" className="[&.active]:font-bold">
        About
      </Link>
      <Outlet />
    </>
  )
}

export const Route = createFileRoute('/_authenticated')({
  beforeLoad: async ({ context, location }) => {
    try {
      await context.queryClient.ensureQueryData(getSessionQueryOptions())
    } catch (err) {
      if (err instanceof InternalApiException && err.status === 401) {
        throw redirect({ to: '/login', search: { redirect: location.href } })
      }
      throw err
    }
  },
  component: AuthenticatedRoute,
})
