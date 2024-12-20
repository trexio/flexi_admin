import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="floating-toc"
export default class extends Controller {
  static targets = ["toc"];

  connect() {
    this._buildToc();
  }

  _buildToc() {
    // Find the TOC target element
    const tocTarget = this.tocTarget;
    if (!tocTarget) return;

    // Find all elements with the .toc class
    const tocChapters = document.querySelectorAll(".toc");

    // Create a list item for each chapter
    tocChapters.forEach((chapter) => {
      const title = chapter.innerHTML;
      const id = chapter.id;

      // Create the list item and link
      const listItem = document.createElement("li");
      listItem.classList.add("nav-item");

      const link = document.createElement("a");
      link.classList.add("nav-link");
      link.href = `#${id}`;
      link.textContent = title;
      link.setAttribute("data-turbo", "false");

      // Append the link to the list item, and the list item to the TOC target
      listItem.appendChild(link);
      tocTarget.appendChild(listItem);
    });
  }
}
