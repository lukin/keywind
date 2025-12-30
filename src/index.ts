import './index.css';

import Alpine from 'alpinejs';

window.Alpine = Alpine;

Alpine.start();

// Dark mode detection and class management
// This runs after page load to handle dynamic changes
function initDarkMode() {
  const htmlElement = document.documentElement;
  
  // Check if Keycloak has already added the dark class
  // If not, detect system preference and add it
  const hasDarkClass = htmlElement.classList.contains('dark');
  const hasLightClass = htmlElement.classList.contains('light');
  
  if (!hasDarkClass && !hasLightClass) {
    // Check system preference
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    
    if (prefersDark) {
      htmlElement.classList.add('dark');
    } else {
      htmlElement.classList.add('light');
    }
  }
  
  // Listen for system preference changes
  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
    if (e.matches) {
      htmlElement.classList.add('dark');
      htmlElement.classList.remove('light');
    } else {
      htmlElement.classList.remove('dark');
      htmlElement.classList.add('light');
    }
  });
}

// Initialize dark mode
initDarkMode();
