// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick/chart.js"

import React from 'react'
import ReactDOM from 'react-dom'
import HelloWorld from 'components/HelloWorld'

document.addEventListener('turbo:load', () => {
  const reactRoot = document.getElementById('react-root')
  if (reactRoot) {
    ReactDOM.render(
      <React.StrictMode>
        <HelloWorld />
      </React.StrictMode>,
      reactRoot
    )
  }
})
