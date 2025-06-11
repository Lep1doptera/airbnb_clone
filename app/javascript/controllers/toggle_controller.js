import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["bookingForm"]

  fire() {
    this.bookingFormTarget.classList.toggle("d-none");
  }
}
