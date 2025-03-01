import { Controller } from "@hotwired/stimulus"
import Chart from "chart.js/auto"

export default class extends Controller {
  static targets = ["canvas"]
  
  connect() {
    if (this.hasCanvasTarget) {
      this.initializeChart()
    }
  }
  
  initializeChart() {
    const ctx = this.canvasTarget.getContext('2d')
    const data = JSON.parse(this.canvasTarget.dataset.chartData)
    
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: data.map(d => d.date),
        datasets: [
          {
            label: 'Max Weight (kg)',
            data: data.map(d => d.max_weight),
            borderColor: 'rgb(79, 70, 229)',
            backgroundColor: 'rgba(79, 70, 229, 0.1)',
            tension: 0.1
          },
          {
            label: 'Volume (kg)',
            data: data.map(d => d.total_volume),
            borderColor: 'rgb(16, 185, 129)',
            backgroundColor: 'rgba(16, 185, 129, 0.1)',
            tension: 0.1
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    })
  }
} 