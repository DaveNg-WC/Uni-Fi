import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["date"]
  connect() {
    console.log("test")
  }
  paymentDueDate(event) {
    console.log("test")
    if (event.target.value === "Credit") {
      this.dateTarget.style.display = "block";
    } else {
      this.dateTarget.style.display = "none";
    }
  }
}
