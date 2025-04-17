import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    allowBackgroundClose: { type: Boolean, default: true }
  }
  
  connect() {
    this.handleKeyboard = this.handleKeyboard.bind(this);
    document.addEventListener('keydown', this.handleKeyboard);
  }
  
  disconnect() {
    document.removeEventListener('keydown', this.handleKeyboard);
  }
  
  open(event) {
    event.preventDefault();
    const targetId = event.currentTarget.dataset.modalTarget;
    const modal = document.querySelector(`[data-modal-target="${targetId}"]`);
    
    if (modal) {
      modal.classList.remove('hidden');
    }
  }
  
  close(event) {
    if (event && !this.allowBackgroundCloseValue && event.target === event.currentTarget) {
      return;
    }
    
    this.element.classList.add('hidden');
  }
  
  handleKeyboard(event) {
    if (event.key === 'Escape' && !this.element.classList.contains('hidden')) {
      this.close();
    }
  }
}