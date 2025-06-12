import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["status", "select"]

  updateStatus(event) {
    console.log("Dropdown changed!");
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
    })
    .catch(error => {
      alert("Failed to update status.")
    })
  }
}
