import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="transaction"
export default class TransactionController extends Controller {
  connect() {
    console.log("dogcat")

    const expense = document.getElementById("expense");
    console.log(expense.checked);
    const transfer = document.getElementById("transfer");
    console.log(transfer.checked);
    const income = document.getElementById("income");
    console.log(income.checked);

    const expenseform = document.getElementById("expenseform");
    console.log(expenseform);
    const transferform = document.getElementById("transferform");
    console.log(transferform);
    const incomeform = document.getElementById("incomeform");
    console.log(incomeform);

    expense.addEventListener("change", function() {
      if (this.checked) {
        console.log("done expense");
        expenseform.classList.remove("d-none");
        transferform.classList.add("d-none");
        incomeform.classList.add("d-none");
      }
    });

    transfer.addEventListener("change", function() {
      if (this.checked) {
        console.log("done transfer");
        expenseform.classList.add("d-none");
        transferform.classList.remove("d-none");
        incomeform.classList.add("d-none");
      }
    });

    income.addEventListener("change", function() {
      if (this.checked) {
        console.log("done income");
        expenseform.classList.add("d-none");
        transferform.classList.add("d-none");
        incomeform.classList.remove("d-none");
      }
    });

    // expense.addEventListener("change", function() {
    //   console.log("done expense")
    //   expenseform.classList.remove("d-none");
    // });

    // transfer.addEventListener("change", function() {
    //   console.log("done transfer")
    //   transferform.classList.remove("d-none");
    // });

    // income.addEventListener("change", function() {
    //   console.log("done income")
    //   incomeform.classList.remove("d-none");
    // });
  }
}
