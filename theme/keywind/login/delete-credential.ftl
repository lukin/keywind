<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>

<@layout.registrationLayout displayMessage=false; section>
  <#if section = "header">
    ${msg("deleteCredentialTitle", credentialLabel)}
  <#elseif section = "form">
    <div id="kc-delete-text">
      ${msg("deleteCredentialMessage", credentialLabel)}
    </div>
    <form class="form-actions space-y-1" action="${url.loginAction}" method="POST">
      <@button.kw name="accept" color="primary" type="submit">${msg("doConfirmDelete")}</@button.kw>
      <@button.kw name="cancel-aia" color="secondary" type="submit">${msg("doCancel")}</@button.kw>
    </form>
  </#if>
</@layout.registrationLayout>
