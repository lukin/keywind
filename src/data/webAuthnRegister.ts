import Alpine from 'alpinejs';
import { base64url } from 'rfc4648';

type DataType = {
  $refs: RefsType;
  $store: StoreType;
};

type RefsType = {
  attestationObjectInput: HTMLInputElement;
  authenticatorLabelInput: HTMLInputElement;
  clientDataJSONInput: HTMLInputElement;
  errorInput: HTMLInputElement;
  publicKeyCredentialIdInput: HTMLInputElement;
  registerForm: HTMLFormElement;
  transportsInput: HTMLInputElement;
};

type StoreType = {
  webAuthnRegister: {
    attestationConveyancePreference: AttestationConveyancePreference | 'not specified';
    authenticatorAttachment: AuthenticatorAttachment | 'not specified';
    challenge: string;
    createTimeout: string;
    excludeCredentialIds: string;
    requireResidentKey: string;
    rpEntityName: string;
    rpId: string;
    signatureAlgorithms: string;
    unsupportedBrowserText: string;
    userId: string;
    userVerificationRequirement: UserVerificationRequirement | 'not specified';
    username: string;
  };
};

document.addEventListener('alpine:init', () => {
  Alpine.data('webAuthnRegister', function (this: DataType) {
    const {
      attestationObjectInput,
      authenticatorLabelInput,
      clientDataJSONInput,
      errorInput,
      publicKeyCredentialIdInput,
      registerForm,
      transportsInput,
    } = this.$refs;
    const {
      attestationConveyancePreference,
      authenticatorAttachment,
      challenge,
      createTimeout,
      excludeCredentialIds,
      requireResidentKey,
      rpEntityName,
      rpId,
      signatureAlgorithms,
      unsupportedBrowserText,
      userId,
      userVerificationRequirement,
      username,
    } = this.$store.webAuthnRegister;

    const getPubKeyCredParams = (signatureAlgorithms: string) => {
      const pubKeyCredParams: PublicKeyCredentialParameters[] = [];

      if (signatureAlgorithms === '') {
        pubKeyCredParams.push({ alg: -7, type: 'public-key' });

        return pubKeyCredParams;
      }

      const signatureAlgorithmsList = signatureAlgorithms.split(',');

      signatureAlgorithmsList.forEach((value) => {
        pubKeyCredParams.push({
          alg: parseInt(value),
          type: 'public-key',
        });
      });

      return pubKeyCredParams;
    };

    const getExcludeCredentials = (excludeCredentialIds: string) => {
      const excludeCredentials: PublicKeyCredentialDescriptor[] = [];

      if (excludeCredentialIds === '') return excludeCredentials;

      const excludeCredentialIdsList = excludeCredentialIds.split(',');

      excludeCredentialIdsList.forEach((value) => {
        excludeCredentials.push({
          id: base64url.parse(value, { loose: true }),
          type: 'public-key',
        });
      });

      return excludeCredentials;
    };

    const getTransportsAsString = (transportsList: string | string[]) => {
      if (transportsList === '' || transportsList.constructor !== Array) return '';

      let transportsString = '';

      transportsList.forEach((value) => {
        transportsString += value + ',';
      });

      return transportsString.slice(0, -1);
    };

    return {
      registerSecurityKey: () => {
        if (!window.PublicKeyCredential) {
          errorInput.value = unsupportedBrowserText;
          registerForm.submit();

          return;
        }

        const publicKey: PublicKeyCredentialCreationOptions = {
          challenge: base64url.parse(challenge, { loose: true }),
          pubKeyCredParams: getPubKeyCredParams(signatureAlgorithms),
          rp: {
            id: rpId,
            name: rpEntityName,
          },
          user: {
            displayName: username,
            id: base64url.parse(userId, { loose: true }),
            name: username,
          },
        };

        if (attestationConveyancePreference !== 'not specified')
          publicKey.attestation = attestationConveyancePreference;

        const authenticatorSelection: AuthenticatorSelectionCriteria = {};
        let isAuthenticatorSelectionSpecified = false;

        if (authenticatorAttachment !== 'not specified') {
          authenticatorSelection.authenticatorAttachment = authenticatorAttachment;
          isAuthenticatorSelectionSpecified = true;
        }

        if (requireResidentKey !== 'not specified') {
          if (requireResidentKey === 'Yes') authenticatorSelection.requireResidentKey = true;
          else authenticatorSelection.requireResidentKey = false;
          isAuthenticatorSelectionSpecified = true;
        }

        if (userVerificationRequirement !== 'not specified') {
          authenticatorSelection.userVerification = userVerificationRequirement;
          isAuthenticatorSelectionSpecified = true;
        }

        if (isAuthenticatorSelectionSpecified)
          publicKey.authenticatorSelection = authenticatorSelection;

        const excludeCredentials = getExcludeCredentials(excludeCredentialIds);
        if (excludeCredentials.length > 0) publicKey.excludeCredentials = excludeCredentials;

        if (parseInt(createTimeout) !== 0) publicKey.timeout = parseInt(createTimeout) * 1000;

        navigator.credentials
          .create({ publicKey })
          .then((result) => {
            if (
              result instanceof PublicKeyCredential &&
              result.response instanceof AuthenticatorAttestationResponse
            ) {
              const { getTransports } = result.response;

              window.result = result;

              const publicKeyCredentialId = result.rawId;

              attestationObjectInput.value = base64url.stringify(
                new Uint8Array(result.response.attestationObject),
                { pad: false }
              );

              clientDataJSONInput.value = base64url.stringify(
                new Uint8Array(result.response.clientDataJSON),
                { pad: false }
              );

              publicKeyCredentialIdInput.value = base64url.stringify(
                new Uint8Array(publicKeyCredentialId),
                { pad: false }
              );

              if (typeof getTransports === 'function') {
                const transports = getTransports();

                if (transports) {
                  transportsInput.value = getTransportsAsString(transports);
                }
              } else {
                console.log(
                  'Your browser is not able to recognize supported transport media for the authenticator.'
                );
              }

              const initLabel = 'WebAuthn Authenticator (Default Label)';
              let labelResult = window.prompt(
                "Please input your registered authenticator's label",
                initLabel
              );
              if (labelResult === null) labelResult = initLabel;

              authenticatorLabelInput.value = labelResult;
              registerForm.submit();
            }
          })
          .catch(function (error) {
            error.value = error;
            registerForm.submit();
          });
      },
    };
  });
});
