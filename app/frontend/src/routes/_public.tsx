import { createFileRoute, Outlet } from '@tanstack/react-router'
import type { ReactNode } from 'react'

interface PublicLayoutProps {
  children: ReactNode
}

function PublicLayout({ children }: PublicLayoutProps) {
  return (
    <>
      <h1>Public</h1>
      {children}
    </>
  )
}

export const Route = createFileRoute('/_public')({
  component: () => (
    <PublicLayout>
      <Outlet />
    </PublicLayout>
  ),
})
