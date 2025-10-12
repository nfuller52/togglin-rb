export type InternalApiError = {
  message: string
  errors?: string[]
}

export class InternalApiException extends Error {
  status: number
  errors: string[]

  constructor(message: string, status: number, errors?: string[]) {
    super(message)
    this.name = 'InternalApiException'
    this.status = status
    this.errors = errors ?? []

    Object.setPrototypeOf(this, InternalApiException.prototype)
  }
}
