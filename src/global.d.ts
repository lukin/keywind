import type { Alpine } from 'alpinejs';

declare global {
  interface Window {
    Alpine: Alpine;
    result?: PublicKeyCredential;
  }
}
