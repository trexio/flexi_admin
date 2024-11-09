import { Controller } from "@hotwired/stimulus";
import { fetchContent } from "../utils";

// Connects to data-controller="form"
export default class extends Controller {
  static values = {
    resourcePath: String,
  };

  enable(event) {
    fetchContent(event, this.resourcePathValue);
  }

  disable(event) {
    fetchContent(event, this.resourcePathValue);
  }
}
