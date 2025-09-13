// App.jsx

import React, { useState } from "react"

export default function App() {
  const [count, setCount] = useState(0)

  // Example of a function with unused variable (ESLint should warn)
  function add(a, b) {
    p = { a: 1, b:3, c: {d: 4}, d: 4, d: 4 }
    return a + b
  }

  // Example of inline style (some ESLint configs may warn)
  return (
    <div style={{ padding: "2rem", fontFamily: "sans-serif" }}>
      <h1>Hello Neovim + React 🚀</h1>
      <p>Count: {count}</p>
      <button
        onClick={() => setCount(count + 1)}
        className="bg-blue-500 text-white px-4 py-2 rounded"
      >
        Increment
      </button>
    </div>
  )
}
