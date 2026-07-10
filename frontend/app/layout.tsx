// frontend/app/layout.tsx
// Root layout — wraps app with ClerkProvider
// TODO Phase 1 (Day 7)
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
