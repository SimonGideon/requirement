import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    index: { type: Number, default: 0 }
  }
  
  connect() {
    // Find the highest index currently in the form to avoid duplicate indices
    const existingFields = document.querySelectorAll('.requirement-fields');
    if (existingFields.length > 0) {
      const indices = Array.from(existingFields).map(field => {
        const input = field.querySelector('input[name$="[title]"]');
        if (input) {
          const match = input.name.match(/\[(\d+)\]/);
          if (match) return parseInt(match[1], 10);
        }
        return 0;
      });
      this.indexValue = Math.max(...indices) + 1;
    }
  }
  
  add(event) {
    event.preventDefault();
    const noRequirementsMessage = document.getElementById('no-requirements-message');
    if (noRequirementsMessage) {
      noRequirementsMessage.remove();
    }
    
    const template = document.getElementById('requirement-template');
    const clone = template.content.cloneNode(true);
    
    // Update all field names with the correct index
    const fields = clone.querySelectorAll('input, select, textarea');
    fields.forEach(field => {
      field.name = field.name.replace(/\[new_record\]/, `[${this.indexValue}]`);
    });
    
    document.getElementById('requirements-container').appendChild(clone);
    this.indexValue++;
  }
  
  remove(event) {
    const fieldset = event.target.closest('.requirement-fields');
    if (fieldset.dataset.newRecord) {
      // For newly added fields, just remove from DOM
      fieldset.remove();
    } else {
      // For existing records, mark for destruction and hide
      const destroyField = fieldset.querySelector('input[name$="[_destroy]"]');
      if (destroyField) {
        destroyField.value = '1';
        fieldset.style.display = 'none';
      }
    }
  }
}