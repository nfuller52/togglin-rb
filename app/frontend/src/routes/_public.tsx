import type { ReactNode } from 'react'

import { createFileRoute, Outlet } from '@tanstack/react-router'

interface PublicLayoutProps {
  children: ReactNode
}

function PublicLayout({ children }: PublicLayoutProps) {
  return (
    <div className="flex min-h-screen flex-col overflow-hidden supports-[overflow:clip]:overflow-clip">
      <div className="flex min-h-screen flex-col">
        <header className="absolute z-30 w-full">
          <div className="mx-auto max-w-6xl px-4 sm:px-6">
            <div className="flex h-16 items-center justify-between md:h-20">
              <div className="mr-4 shrink-0">
                <div className="cursor-pointer hover:opacity-80 transition-opacity"></div>
              </div>
            </div>
          </div>
        </header>
        <main className="relative flex grow">
          <div className="w-full">
            <div className="flex h-full flex-col justify-center before:min-h-[4rem] before:flex-1 after:flex-1 md:before:min-h-[5rem]">
              <div className="px-4 sm:px-6">
                <div className="mx-auto w-full max-w-sm">
                  {/* Card */}

                  {children}
                  {/* EndCard */}
                </div>
              </div>
            </div>
          </div>
          <div className="relative my-6 mr-6 hidden w-[572px] shrink-0 overflow-hidden rounded-2xl lg:block"></div>
        </main>
      </div>
    </div>
  )
}

export const Route = createFileRoute('/_public')({
  component: () => (
    <PublicLayout>
      <Outlet />
    </PublicLayout>
  ),
})
