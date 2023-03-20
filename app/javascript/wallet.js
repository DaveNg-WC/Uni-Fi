import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "paymentDueDate" ]

  toggleFields() {
    const type = this.element.querySelector("select[name='wallet[type]']").value
    if (type == "Credit") {
      this.paymentDueDateTarget.classList.remove("hidden")
    } else {
      this.paymentDueDateTarget.classList.add("hidden")
    }
  }
}
