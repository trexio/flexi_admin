import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="button-select"
export default class extends Controller {
  static targets = ["button", "input"];
  static values = { disabled: Boolean };

  connect() {
    this._updateSelectedButton();
  }

  select(event) {
    if (this.disabledValue) {
      return;
    }

    event.preventDefault();
    const selectedValue = event.currentTarget.dataset.value;
    this.inputTarget.value = selectedValue;
    this._updateSelectedButton();
  }

  _updateSelectedButton() {
    this.buttonTargets.forEach((button) => {
      button.classList.toggle(
        "selected",
        button.dataset.value === this.inputTarget.value
      );
      button.classList.toggle("disabled", this.disabledValue);
    });
  }
}
