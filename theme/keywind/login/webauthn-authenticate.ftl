<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/button/secondary.ftl" as buttonSecondary>

<@layout.registrationLayout; section>
<#if section="header">
    ${msg("webauthn-login-title")}

<#elseif section = "form">
    <div class="m-0">
        <form id="webauth" action="${url.loginAction}" method="post">
            <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
            <input type="hidden" id="authenticatorData" name="authenticatorData"/>
            <input type="hidden" id="signature" name="signature"/>
            <input type="hidden" id="credentialId" name="credentialId"/>
            <input type="hidden" id="userHandle" name="userHandle"/>
            <input type="hidden" id="error" name="error"/>
        </form>

        <#if authenticators??>
            <form id="authn_select" class="m-0">
                <#list authenticators.authenticators as authenticator>
                    <input type="hidden" name="authn_use_chk" value="${authenticator.credentialId}"/>
                </#list>
            </form>

            <#if shouldDisplayAuthenticators?? && shouldDisplayAuthenticators>
                <#if authenticators.authenticators?size gt 1>
                    <p class="font-bold py-2 text-xl">${kcSanitize(msg("webauthn-available-authenticators"))?no_esc}</p>
                </#if>

                <#list authenticators.authenticators as authenticator>
                    <div class="my-5">
                        <p><span class="font-bold">${kcSanitize(msg('${authenticator.label}'))?no_esc}</span>
                        <#--<#if authenticator.transports?? && authenticator.transports.displayNameProperties?has_content>
                            (<#list authenticator.transports.displayNameProperties as nameProperty>
                                ${kcSanitize(msg('${nameProperty!}'))?no_esc}
                                <#if nameProperty?has_next>, </#if>
                            </#list>)
                        </#if>-->
                        </p>

                        <p>${kcSanitize(msg('webauthn-createdAt-label'))?no_esc}: <span class="font-bold">${kcSanitize(authenticator.createdAt)?no_esc}</span></p>
                    </div>
                </#list>
            </#if>
        </#if>

        <@buttonPrimary.kw type="button" onclick="webAuthnAuthenticate()" autofocus="autofocus">
          ${msg("webauthn-doAuthenticate")}
        </@buttonPrimary.kw>
    </div>

<script type="text/javascript" src="${url.resourcesPath}/js/base64url.js"></script>
<script type="text/javascript">
    function webAuthnAuthenticate() {
        let isUserIdentified = ${isUserIdentified};
        if (!isUserIdentified) {
            doAuthenticate([]);
            return;
        }
        checkAllowCredentials();
    }
    function checkAllowCredentials() {
        let allowCredentials = [];
        let authn_use = document.forms['authn_select'].authn_use_chk;
        if (authn_use !== undefined) {
            if (authn_use.length === undefined) {
                allowCredentials.push({
                    id: base64url.decode(authn_use.value, {loose: true}),
                    type: 'public-key',
                });
            } else {
                for (let i = 0; i < authn_use.length; i++) {
                    allowCredentials.push({
                        id: base64url.decode(authn_use[i].value, {loose: true}),
                        type: 'public-key',
                    });
                }
            }
        }
        doAuthenticate(allowCredentials);
    }
function doAuthenticate(allowCredentials) {
    // Check if WebAuthn is supported by this browser
    if (!window.PublicKeyCredential) {
        document.querySelector("#error").value = "${msg("webauthn-unsupported-browser-text")?no_esc}";
        document.querySelector("#webauth").submit();
        return;
    }
    let challenge = "${challenge}";
    let userVerification = "${userVerification}";
    let rpId = "${rpId}";
    let publicKey = {
        rpId : rpId,
        challenge: base64url.decode(challenge, { loose: true })
    };
    let createTimeout = ${createTimeout};
    if (createTimeout !== 0) publicKey.timeout = createTimeout * 1000;
    if (allowCredentials.length) {
        publicKey.allowCredentials = allowCredentials;
    }
    if (userVerification !== 'not specified') publicKey.userVerification = userVerification;
    navigator.credentials.get({publicKey})
        .then((result) => {
            window.result = result;
            let clientDataJSON = result.response.clientDataJSON;
            let authenticatorData = result.response.authenticatorData;
            let signature = result.response.signature;
            document.querySelector("#clientDataJSON").value = base64url.encode(new Uint8Array(clientDataJSON), { pad: false });
            document.querySelector("#authenticatorData").value = base64url.encode(new Uint8Array(authenticatorData), { pad: false });
            document.querySelector("#signature").value = base64url.encode(new Uint8Array(signature), { pad: false });
            document.querySelector("#credentialId").value = result.id;
            if(result.response.userHandle) {
                document.querySelector("#userHandle").value = base64url.encode(new Uint8Array(result.response.userHandle), { pad: false });
            }
            document.querySelector("#webauth").submit();
        })
        .catch((err) => {
            document.querySelector("#error").value = err;
            document.querySelector("#webauth").submit();
        })
    ;
}
</script>
<#elseif section = "info">

</#if>
</@layout.registrationLayout>
