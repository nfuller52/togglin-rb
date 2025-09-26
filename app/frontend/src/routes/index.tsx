import { createFileRoute } from '@tanstack/react-router'

function Index() {
  return <div>Index</div>
}

export const Route = createFileRoute('/')({ component: Index })
