<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/radio/primary.ftl" as radioPrimary>
<#import "components/label/totp.ftl" as labelTotp>
<#import "components/link/secondary.ftl" as linkSecondary>

<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError('totp')
  ;
  section
>
  <#if section="header">
      ${msg("doLogIn")}
  <#elseif section="form">
    <form
      action="${url.loginAction}"
      method="post"
      class="m-0 space-y-4"
    >
      <#if otpLogin.userOtpCredentials?size gt 1>
        <div class="${properties.kcFormGroupClass!}">
          <div class="flex flex-wrap items-center">
            <#list otpLogin.userOtpCredentials as otpCredential>
              <@radioPrimary.kw
                tabIndex="${otpCredential?index}"
                id="kc-otp-credential-${otpCredential?index}"
                name="selectedCredentialId"
                value="${otpCredential.id}"
                checked=(otpCredential.id == otpLogin.selectedCredentialId)
              >
                ${otpCredential.userLabel}
              </@radioPrimary.kw>
            </#list>
          </div>
        </div>
      </#if>

      <div class="py-2">
        <@inputPrimary.kw
          autocomplete="off"
          autofocus=true
          invalid=["otp"]
          name="otp"
          type="text"
          id="otp"
        >
          <@labelTotp.kw />
        </@inputPrimary.kw>
      </div>

      <div class="py-2 flex flex-col items-center justify-center space-y-2">
        <@buttonPrimary.kw
          name="submitAction"
          type="submit"
          value=msg("doLogIn")
        >
          ${msg("doLogIn")}
        </@buttonPrimary.kw>
      </div>
    </form>
  </#if>
</@layout.registrationLayout>
