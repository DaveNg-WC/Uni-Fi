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
        partnerContent.style.display = 'block'; // Show the content when the toggle switch is checked
        userContent.style.display    = 'none'; // Hide the content when the toggle switch is checked
      } else {
        console.log("uncheck")
        partnerContent.style.display  = 'none'; // Hide the content when the toggle switch is unchecked
        userContent.style.display     = 'block'; // Show the content when the toggle switch is unchecked
      }
    });
  }
}
