import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["status", "select"]

  updateStatus(event) {
    const bookingId = this.element.dataset.bookingId
    const newStatus = event.target.value

    fetch(`/bookings/${bookingId}/update_status`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ booking_status: newStatus })
    })
    .then(response => response.json())
    .then(data => {
      this.statusTarget.textContent = data.booking_status
      this.updateBackgroundClass(data.booking_status)  // Call it here!
    })
    .catch(error => {
      alert("Failed to update status.")
    })
  }

  updateBackgroundClass(status) {
    this.element.classList.remove("bg-warning-subtle", "bg-success-subtle", "bg-light")
    if (status === "pending") {
      this.element.classList.add("bg-warning-subtle")
    } else if (status === "confirmed") {
      this.element.classList.add("bg-success-subtle")
    } else {
      this.element.classList.add("bg-light")
    }
  }
}
