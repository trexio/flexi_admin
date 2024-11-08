import { Controller } from "@hotwired/stimulus";
import { CSRFToken } from "../utils";

export default class extends Controller {
  static targets = [
    "form",
    "list",
    "globalProgress",
    "globalProgressBar",
    "resetButton",
    "filesInput",
  ];

  connect() {
    this.element.addEventListener("direct-uploads:start", (event) => {
      this._initGlobalProgress();
    });

    this.element.addEventListener("direct-upload:initialize", (event) => {
      const { id, file } = event.detail;
      this._initializeFileCard(id, file);
    });

    this.element.addEventListener("direct-upload:progress", (event) => {
      const { id, file, progress } = event.detail;
      this._updateImageProgress(id, progress);
    });

    this.element.addEventListener("direct-upload:end", (event) => {
      const { id, file } = event.detail;
      this._reportCompletion(file, id);
      this._updateImageProgress(id, 100);
      this._updateGlobalProgress();
    });

    this.element.addEventListener("direct-uploads:end", (event) => {
      this.resetButtonTarget.classList.remove("d-none");
    });

    this.element.addEventListener("direct-upload:error", (event) => {
      const { id } = event.detail;
      this._setErrorProgress(id);
    });
  }

  resetForm() {
    this.formTarget.reset();
    // hide global progress
    this.globalProgressTarget.classList.remove("show");
    // hide reset button
    this.resetButtonTarget.classList.add("d-none");
    // reset counters
    this.totalCount = 0;
    this.currentCount = 0;
    // clear list
    this.listTarget.innerHTML = "";
    // enable the input field
    this.filesInputTarget.disabled = false;
  }

  _initGlobalProgress(totalCount) {
    const filesInput = this.filesInputTarget;
    this.totalCount = filesInput.files.length;
    this.currentCount = 0;

    this.globalProgressTarget.classList.add("show");
    this.globalProgressBarTarget.style.width = `${0}%`;
    this.globalProgressBarTarget.setAttribute("aria-valuenow", 0);
    this.globalProgressBarTarget.textContent = `0/${totalCount}`;
  }

  _updateGlobalProgress() {
    const globalProgressBar = this.globalProgressBarTarget;
    this.currentCount += 1;

    const perCent = (this.currentCount / this.totalCount) * 100;
    globalProgressBar.style.width = `${perCent}%`;
    globalProgressBar.setAttribute("aria-valuenow", perCent);
    globalProgressBar.textContent = `${this.currentCount}/${this.totalCount}`;
  }

  _setErrorProgress(id) {
    const element = document.getElementById(`upload-${id}`);
    const progressBar = element.querySelector(".progress-bar");
    progressBar.classList.add("bg-danger");
    progressBar.style.width = "100%";
    progressBar.setAttribute("aria-valuenow", 100);
  }

  _updateImageProgress(id, progress) {
    const element = document.getElementById(`upload-${id}`);
    const progressBar = element.querySelector(".progress-bar");
    progressBar.style.width = `${progress}%`;
    progressBar.setAttribute("aria-valuenow", progress);
  }

  _switchToVideo(id, url) {
    const element = document.getElementById(`upload-${id}`);
    const videoContainer = element.querySelector(".upload-video");
    const video = element.querySelector(".upload-video video");
    const icon = element.querySelector(".upload-icon");
    video.src = url;
    icon.classList.add("d-none");
    videoContainer.classList.add("show");
  }

  _switchToImage(id, url) {
    const element = document.getElementById(`upload-${id}`);
    const imageContainer = element.querySelector(".upload-image");
    const image = element.querySelector(".upload-image img");
    const icon = element.querySelector(".upload-icon");
    image.src = url;
    icon.classList.add("d-none");
    imageContainer.classList.add("show");
  }

  _reportCompletion(file, id) {
    const name = file.name;
    const size = file.size;

    fetch("/uploads/soft_completed", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": CSRFToken(),
        Accept: "application/json",
      },
      body: JSON.stringify({ name, size }),
    })
      .then((response) => response.json())
      .then((data) => {
        const { url, kind } = data;
        if (url) {
          if (kind === "video") {
            this._switchToVideo(id, url);
          } else {
            this._switchToImage(id, url);
          }
        }
      })
      .catch((error) => console.error("Error:", error));
  }

  _initializeFileCard(id, file) {
    const name = file.name;
    const size = file.size;
    const contentType = file.type;

    fetch("/uploads/initialize_upload", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": CSRFToken(),
        Accept: "text/html",
      },
      body: JSON.stringify({ id, name, size, contentType }),
    })
      .then((response) => response.text())
      .then((html) => {
        this.listTarget.insertAdjacentHTML("afterbegin", html);
      })
      .catch((error) => console.error("Error:", error));
  }
}
