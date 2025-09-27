import { createFileRoute } from '@tanstack/react-router'

function Login() {
  return <div>Login</div>
}

export const Route = createFileRoute('/_public/login')({ component: Login })
