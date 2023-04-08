import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="partner"
export default class PartnerController extends Controller {
  connect() {
    console.log("hello");
    const partnerToggle   = document.getElementById("partner-toggle");
    const partnerContent  = document.getElementById("partner-content");
    const userContent  = document.getElementById("user-content");

    partnerToggle.addEventListener('change', () => {
      if (partnerToggle.checked) {
        console.log("checked")
        partnerContent.classList.remove("d-none")
        userContent.classList.add("d-none")
      } else {
        console.log("uncheck")
        partnerContent.classList.add("d-none");       // Hide the content when the toggle switch is unchecked
        userContent.classList.remove("d-none");       // Show the content when the toggle switch is unchecked


      }
    });
  }
}
