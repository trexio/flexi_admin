import { Controller } from "@hotwired/stimulus";
import { fetchContent } from "../utils";

// Connects to data-controller="switch-view"
export default class extends Controller {
  static values = {
    resourcePath: String,
  };

  connect() {}

  switch(event) {
    fetchContent(event, this.resourcePathValue);
  }
}
