import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bottom-sheet"
export default class extends Controller {
  static targets = ["sheet", "overlay", "content"];

  connect() {
    this.startY = 0;
    this.currentY = 0;
    this.isDragging = false;

    this.dragStart = this.dragStart.bind(this);
    this.dragMove = this.dragMove.bind(this);
    this.dragEnd = this.dragEnd.bind(this);

    this.contentTarget.addEventListener("touchstart", this.dragStart, { passive: true });
    this.contentTarget.addEventListener("touchmove", this.dragMove, { passive: true });
    this.contentTarget.addEventListener("touchend", this.dragEnd);
  }

  disconnect() {
    this.contentTarget.removeEventListener("touchstart", this.dragStart);
    this.contentTarget.removeEventListener("touchmove", this.dragMove);
    this.contentTarget.removeEventListener("touchend", this.dragEnd);
  }

  open() {
    this.sheetTarget.classList.remove("hidden");
    document.body.classList.add("overflow-hidden");
    setTimeout(() => {
      this.overlayTarget.classList.add("!bg-opacity-75");
      this.contentTarget.classList.remove("translate-y-full", "lg:scale-95");
      this.contentTarget.classList.add("lg:scale-100");
    }, 10);
  }

  close() {
    if (window.innerWidth >= 768) {
      this.sheetTarget.classList.add("hidden");
    }
    this.contentTarget.style.transform = "";
    this.overlayTarget.classList.remove("!bg-opacity-75");
    this.contentTarget.classList.add("translate-y-full", "lg:scale-95");
    this.contentTarget.classList.remove("lg:scale-100");
    document.body.classList.remove("overflow-hidden");

    if (window.innerWidth >= 768) return;

    this.sheetTarget.addEventListener('transitionend', (event) => {
      if (event.propertyName === 'transform' || event.propertyName === 'opacity') {
        this.sheetTarget.classList.add("hidden");
      }
    }, { once: true });
  }

  dragStart(event) {
    if (window.innerWidth >= 768) return; // Disable drag on md screens and up
    if (this.contentTarget.scrollTop > 0) {
      this.isDragging = false;
      return;
    }
    this.isDragging = true;
    this.startY = event.touches ? event.touches[0].pageY : event.pageY;
    this.contentTarget.style.transition = "none";
  }

  dragMove(event) {
    if (window.innerWidth >= 768) return; // Disable drag on md screens and up
    if (!this.isDragging) return;

    this.currentY = event.touches ? event.touches[0].pageY : event.pageY;
    const diff = this.currentY - this.startY;

    if (diff > 0) {
      this.contentTarget.style.transform = `translateY(${diff}px)`;
    }
  }

  dragEnd() {
    if (window.innerWidth >= 768) return; // Disable drag on md screens and up
    if (!this.isDragging) return;
    this.isDragging = false;

    this.contentTarget.style.transition = "transform 0.2s ease-out";
    const diff = this.currentY - this.startY;

    if (diff > 100) { // If dragged more than 100px, close
      this.close();
    } else {
      this.contentTarget.style.transform = "translateY(0)";
    }
  }
}

