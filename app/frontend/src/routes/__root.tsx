import { Link, Outlet, createRootRoute } from '@tanstack/react-router'

function RootLayout() {
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

export const Route = createRootRoute({ component: RootLayout })
