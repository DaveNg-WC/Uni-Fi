import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="partner"
export default class DashboardController extends Controller {
  connect() {
    console.log("dashboard_controller.js working");

    // ------------------ Toggle event -------------------------------- //
    const partnerToggle   = document.getElementById("partner-toggle");
    const partnerContent  = document.getElementById("partner-content");
    const userContent     = document.getElementById("user-content");

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


    // ------------------ User Week/Month/Year -------------------------------- //
    const week         = document.getElementById("week");
    const month        = document.getElementById("month");
    const year         = document.getElementById("year");

    const weekGrpahs   = document.getElementById("week-graphs");
    const monthGrpahs  = document.getElementById("month-graphs");
    const yearGrpahs   = document.getElementById("year-graphs");

    const weekLabel    = document.getElementById("week-label");
    const monthLabel   = document.getElementById("month-label");
    const yearLabel    = document.getElementById("year-label");


    week.addEventListener("change", function() {
      if (this.checked) {
        console.log("week btn")
        weekGrpahs.classList.remove("d-none");
        monthGrpahs.classList.add("d-none");
        yearGrpahs.classList.add("d-none");

        weekLabel.classList.add("selected");
        monthLabel.classList.remove("selected");
        yearLabel.classList.remove("selected");
      }
    });

    month.addEventListener("change", function() {
      if (this.checked) {
        console.log("month btn")
        weekGrpahs.classList.add("d-none");
        monthGrpahs.classList.remove("d-none");
        yearGrpahs.classList.add("d-none");

        weekLabel.classList.remove("selected");
        monthLabel.classList.add("selected");
        yearLabel.classList.remove("selected");
      }
    });

    year.addEventListener("change", function() {
      if (this.checked) {
        console.log("year btn")
        weekGrpahs.classList.add("d-none");
        monthGrpahs.classList.add("d-none");
        yearGrpahs.classList.remove("d-none");

        weekLabel.classList.remove("selected");
        monthLabel.classList.remove("selected");
        yearLabel.classList.add("selected");
      }
    });

     // ------------------ Partner Week/Month/Year  -------------------------------- //
     const weekPartner         = document.getElementById("week-partner");
     const monthPartner        = document.getElementById("month-partner");
     const yearPartner         = document.getElementById("year-partner");

     const weekGrpahsPartner   = document.getElementById("week-graphs-partner");
     const monthGrpahsPartner  = document.getElementById("month-graphs-partner");
     const yearGrpahsPartner   = document.getElementById("year-graphs-partner");

     const weekLabelPartner    = document.getElementById("week-label-partner");
     const monthLabelPartner   = document.getElementById("month-label-partner");
     const yearLabelPartner    = document.getElementById("year-label-partner");


     weekPartner.addEventListener("change", function() {
       if (this.checked) {
         console.log("week btn")
         weekGrpahsPartner.classList.remove("d-none");
         monthGrpahsPartner.classList.add("d-none");
         yearGrpahsPartner.classList.add("d-none");

         weekLabelPartner.classList.add("selected");
         monthLabelPartner.classList.remove("selected");
         yearLabelPartner.classList.remove("selected");
       }
     });

     monthPartner.addEventListener("change", function() {
       if (this.checked) {
         console.log("month btn")
         weekGrpahsPartner.classList.add("d-none");
         monthGrpahsPartner.classList.remove("d-none");
         yearGrpahsPartner.classList.add("d-none");

         weekLabelPartner.classList.remove("selected");
         monthLabelPartner.classList.add("selected");
         yearLabelPartner.classList.remove("selected");
       }
     });

     yearPartner.addEventListener("change", function() {
       if (this.checked) {
         console.log("year btn")
         weekGrpahsPartner.classList.add("d-none");
         monthGrpahsPartner.classList.add("d-none");
         yearGrpahsPartner.classList.remove("d-none");

         weekLabelPartner.classList.remove("selected");
         monthLabelPartner.classList.remove("selected");
         yearLabelPartner.classList.add("selected");
       }
     });


  }
}
