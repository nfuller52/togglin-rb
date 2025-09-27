import { createFileRoute } from '@tanstack/react-router'

function Index() {
  return (
    <div className="flex">
      <h1 className="mt-12">Index</h1>
      <h1 className="pt-12">Hi Mom</h1>
    </div>
  )
}

export const Route = createFileRoute('/')({ component: Index })
