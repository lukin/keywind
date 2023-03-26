import Alpine from 'alpinejs';
import { base64url } from 'rfc4648';

type DataType = {
  $refs: RefsType;
  $store: StoreType;
};

type RefsType = {
  authenticatorDataInput: HTMLInputElement;
  authnSelectForm?: HTMLFormElement;
  clientDataJSONInput: HTMLInputElement;
  credentialIdInput: HTMLInputElement;
  errorInput: HTMLInputElement;
  signatureInput: HTMLInputElement;
  userHandleInput: HTMLInputElement;
  webAuthnForm: HTMLFormElement;
};

type StoreType = {
  webAuthnAuthenticate: {
    challenge: string;
    createTimeout: string;
    isUserIdentified: string;
    rpId: string;
    unsupportedBrowserText: string;
    userVerification: UserVerificationRequirement | 'not specified';
  };
};

document.addEventListener('alpine:init', () => {
  Alpine.data('webAuthnAuthenticate', function (this: DataType) {
    const {
      authenticatorDataInput,
      authnSelectForm,
      clientDataJSONInput,
      credentialIdInput,
      errorInput,
      signatureInput,
      userHandleInput,
      webAuthnForm,
    } = this.$refs;
    const {
      challenge,
      createTimeout,
      isUserIdentified,
      rpId,
      unsupportedBrowserText,
      userVerification,
    } = this.$store.webAuthnAuthenticate;

    const doAuthenticate = (allowCredentials: PublicKeyCredentialDescriptor[]) => {
      if (!window.PublicKeyCredential) {
        errorInput.value = unsupportedBrowserText;
        webAuthnForm.submit();

        return;
      }

      const publicKey: PublicKeyCredentialRequestOptions = {
        challenge: base64url.parse(challenge, { loose: true }),
        rpId: rpId,
      };

      if (allowCredentials.length) {
        publicKey.allowCredentials = allowCredentials;
      }

      if (parseInt(createTimeout) !== 0) publicKey.timeout = parseInt(createTimeout) * 1000;

      if (userVerification !== 'not specified') publicKey.userVerification = userVerification;

      navigator.credentials
        .get({ publicKey })
        .then((result) => {
          if (
            result instanceof PublicKeyCredential &&
            result.response instanceof AuthenticatorAssertionResponse
          ) {
            window.result = result;

            authenticatorDataInput.value = base64url.stringify(
              new Uint8Array(result.response.authenticatorData),
              { pad: false }
            );

            clientDataJSONInput.value = base64url.stringify(
              new Uint8Array(result.response.clientDataJSON),
              { pad: false }
            );

            signatureInput.value = base64url.stringify(new Uint8Array(result.response.signature), {
              pad: false,
            });

            credentialIdInput.value = result.id;

            if (result.response.userHandle) {
              userHandleInput.value = base64url.stringify(
                new Uint8Array(result.response.userHandle),
                { pad: false }
              );
            }

            webAuthnForm.submit();
          }
        })
        .catch((error) => {
          errorInput.value = error;
          webAuthnForm.submit();
        });
    };

    const checkAllowCredentials = () => {
      const allowCredentials: PublicKeyCredentialDescriptor[] = [];

      if (authnSelectForm) {
        const authnSelectFormElements = Array.from(authnSelectForm.elements);

        if (authnSelectFormElements.length) {
          authnSelectFormElements.forEach((element) => {
            if (element instanceof HTMLInputElement) {
              allowCredentials.push({
                id: base64url.parse(element.value, { loose: true }),
                type: 'public-key',
              });
            }
          });
        }
      }

      doAuthenticate(allowCredentials);
    };

    return {
      webAuthnAuthenticate: () => {
        if (!isUserIdentified) {
          doAuthenticate([]);

          return;
        }

        checkAllowCredentials();
      },
    };
  });
});
