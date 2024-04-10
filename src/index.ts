import './index.css';

import Alpine from 'alpinejs';

function setColorScheme(scheme: string) {
    const htmlElement = document.querySelector(':root') as HTMLHtmlElement
    if (scheme == 'dark') {
        htmlElement.classList.add('dark');
    } else {
        htmlElement.classList.remove('dark')
    }
}

function getPreferredColorScheme() {
    if (window.matchMedia) {
        if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
            return 'dark';
        } else {
            return 'light';
        }
    }
    return 'light';
}

function updateColorScheme() {
    setColorScheme(getPreferredColorScheme());
}

if (window.matchMedia) {
    var colorSchemeQuery = window.matchMedia('(prefers-color-scheme: dark)');
    colorSchemeQuery.addEventListener('change', updateColorScheme);
}

updateColorScheme();

window.Alpine = Alpine;

Alpine.start();