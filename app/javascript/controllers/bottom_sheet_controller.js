import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bottom-sheet"
export default class extends Controller {
  static targets = ["sheet", "content"];

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
    // We need a small delay to allow the display property to change to block,
    // so that the transition is applied.
    setTimeout(() => {
      this.sheetTarget.classList.remove("translate-y-full");
    }, 10);
  }

  close() {
    this.sheetTarget.classList.add("translate-y-full");
    document.body.classList.remove("overflow-hidden");
    this.sheetTarget.addEventListener('transitionend', () => {
      this.sheetTarget.classList.add("hidden");
    }, { once: true });
  }

  dragStart(event) {
    if (this.contentTarget.scrollTop > 0) {
      this.isDragging = false;
      return;
    }
    this.isDragging = true;
    this.startY = event.touches ? event.touches[0].pageY : event.pageY;
    this.sheetTarget.style.transition = "none";
  }

  dragMove(event) {
    if (!this.isDragging) return;

    this.currentY = event.touches ? event.touches[0].pageY : event.pageY;
    const diff = this.currentY - this.startY;

    if (diff > 0) {
      this.sheetTarget.style.transform = `translateY(${diff}px)`;
    }
  }

  dragEnd() {
    if (!this.isDragging) return;
    this.isDragging = false;

    this.sheetTarget.style.transition = "transform 0.2s ease-out";
    const diff = this.currentY - this.startY;

    if (diff > 100) { // If dragged more than 100px, close
      this.close();
    } else {
      this.sheetTarget.style.transform = "translateY(0)";
    }
  }
}

