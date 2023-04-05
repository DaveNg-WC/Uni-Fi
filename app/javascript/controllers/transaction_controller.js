import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="transaction"
export default class TransactionController extends Controller {
  connect() {
    console.log("dogcat")

    const expense = document.getElementById("expense");
    const transfer = document.getElementById("transfer");
    const income = document.getElementById("income");

    const expenseform = document.getElementById("expenseform");
    const transferform = document.getElementById("transferform");
    const incomeform = document.getElementById("incomeform");

    const expensechoice = document.getElementById("choice-expense");
    console.log(expensechoice);
    const transferchoice = document.getElementById("choice-transfer");
    console.log(transferchoice);
    const incomechoice = document.getElementById("choice-income");
    console.log(incomechoice);

    expense.addEventListener("change", function() {
      if (this.checked) {
        expenseform.classList.remove("d-none");
        transferform.classList.add("d-none");
        incomeform.classList.add("d-none");

        expensechoice.classList.add("selected");
        transferchoice.classList.remove("selected");
        incomechoice.classList.remove("selected");
      }
    });

    transfer.addEventListener("change", function() {
      if (this.checked) {
        expenseform.classList.add("d-none");
        transferform.classList.remove("d-none");
        incomeform.classList.add("d-none");

        expensechoice.classList.remove("selected");
        transferchoice.classList.add("selected");
        incomechoice.classList.remove("selected");
      }
    });

    income.addEventListener("change", function() {
      if (this.checked) {
        expenseform.classList.add("d-none");
        transferform.classList.add("d-none");
        incomeform.classList.remove("d-none");

        expensechoice.classList.remove("selected");
        transferchoice.classList.remove("selected");
        incomechoice.classList.add("selected");
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
