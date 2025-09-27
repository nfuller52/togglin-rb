import { createFileRoute } from '@tanstack/react-router'

function About() {
  return <div>About</div>
}

export const Route = createFileRoute('/_authenticated/about')({ component: About })
