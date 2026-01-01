import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["shareText"]

  connect() {
  }

  copy(event) {
    event.preventDefault()
    let shareText = this.shareTextTarget.getAttribute("data-share-value")
    if (shareText) {
      navigator.clipboard.writeText(shareText).then()
    }
  }

  shareRoutine(event) {
    event.preventDefault()
    let shareText = this.shareTextTarget.getAttribute("data-share-value")
    const shareData = {
      title: "Check out this routine from Iron Logs:\n",
      text: shareText,
      // url: link TODO: link back to routine page? (public view)
    }
    if (navigator.share && navigator.canShare(shareData)) {
      navigator.share(shareData).catch(() => {
      })
    } else {
      this.copy(event)
      alert("Link copied! You can now paste it anywhere.")
    }
  }
}
