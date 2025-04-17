// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Ensure form submissions work correctly
document.addEventListener('DOMContentLoaded', function() {
  // Handle all forms with method: :delete
  document.querySelectorAll('form[method="delete"]').forEach(form => {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      const formData = new FormData(this);
      fetch(this.action, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        }
      }).then(response => {
        if (response.redirected) {
          window.location.href = response.url;
        }
      });
    });
  });
});
