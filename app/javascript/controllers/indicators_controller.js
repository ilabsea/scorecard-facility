import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['inputRemove', 'displayName', 'audio']

  selectFile(e) {
    this.element.classList.add('file-selected')
    this.inputRemoveTarget.value = '0'
    this.displayNameTarget.text = this.audioTarget.files[0].name
  }

  removeAudio() {
    this.audioTarget.value = ''
    this.inputRemoveTarget.value = '1'
    this.element.classList.remove('file-selected')
  }
}
