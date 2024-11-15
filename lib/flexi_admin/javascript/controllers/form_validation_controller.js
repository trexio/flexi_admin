import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.setCustomValidationMessages();
    this._unhideValidationMessages();
  }

  disconnect() {
    this.removeCustomValidationMessages();
  }

  setCustomValidationMessages() {
    this.getInputFields().forEach((field) => {
      field.addEventListener("invalid", this.handleInvalid);
    });
  }

  removeCustomValidationMessages() {
    this.getInputFields().forEach((field) => {
      field.removeEventListener("invalid", this.handleInvalid);
    });
  }

  getInputFields() {
    return Array.from(
      this.element.querySelectorAll(
        'input:not([type="hidden"]), select, textarea'
      )
    );
  }

  handleInvalid = (event) => {
    const field = event.target;
    if (this.isFieldValid(field)) {
      field.setCustomValidity("");
      return;
    }

    const type = this._isCustomType(field)
      ? field.dataset.fieldType
      : field.type;
    let message = "Toto je povinné pole.";

    switch (type) {
      case "text":
        message = "Toto je povinné pole.";
        break;
      case "autocomplete":
        message = "Najděte a vyberte si položku ze seznamu.";
        break;
      case "email":
        message = "Zadejte platnou emailovou adresu.";
        break;
      case "tel":
        message = "Zadejte platné telefonní číslo.";
        break;
      // Add more cases for other field types as needed
    }

    field.setCustomValidity(message);
  };

  isFieldValid(field) {
    return (
      !field.validity.badInput &&
      !field.validity.valueMissing &&
      !field.validity.typeMismatch &&
      !field.validity.patternMismatch &&
      !field.validity.tooShort &&
      !field.validity.tooLong &&
      !field.validity.rangeUnderflow &&
      !field.validity.rangeOverflow
    );
  }

  _isCustomType(field) {
    return field.dataset.fieldType !== undefined;
  }

  _unhideValidationMessages() {
    this.element.querySelectorAll(".invalid-feedback").forEach((el) => {
      el.classList.add("d-table-cell");
    });
  }
}
