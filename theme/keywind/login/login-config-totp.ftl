<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/button/secondary.ftl" as buttonSecondary>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/label/totp.ftl" as labelTotp>
<#import "components/label/userdevice.ftl" as labelUserDevice>
<#import "components/link/primary.ftl" as linkPrimary>

<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("totp", "userLabel")
  displayRequiredFields=false
  ;
  section
>
  <#if section="header">
    ${msg("loginTotpTitle")}
  <#elseif section="form">
    <ol class="list-decimal pl-4 space-y-2">
      <li>
        <p>${msg("loginTotpStep1")}</p>
        <ul class="list-disc pl-6 py-2 space-y-2">
          <#list totp.policy.supportedApplications as app>
            <li>${app}</li>
          </#list>
        </ul>
      </li>
      <#if mode?? && mode = "manual">
        <li>
          <p>${msg("loginTotpManualStep2")}</p>
          <p class="font-bold py-2 text-xl">${totp.totpSecretEncoded}</p>
        </li>
        <li>
          <@linkPrimary.kw href=totp.qrUrl>
            ${msg("loginTotpScanBarcode")}
          </@linkPrimary.kw>
        </li>
        <li>
          <p>${msg("loginTotpManualStep3")}</p>
          <ul class="list-disc pl-6 py-2 space-y-2">
            <li>${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
            <li>${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
            <li>${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
            <#if totp.policy.type = "totp">
              <li>${msg("loginTotpInterval")}: ${totp.policy.period}</li>
            <#elseif totp.policy.type = "hotp">
              <li>${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
            </#if>
          </ul>
        </li>
      <#else>
        <li>
          <p>${msg("loginTotpStep2")}</p>
          <img
            alt="Figure: Barcode"
            class="mx-auto"
            src="data:image/png;base64, ${totp.totpSecretQrCode}"
          >
          <@linkPrimary.kw href=totp.manualUrl>
            ${msg("loginTotpUnableToScan")}
          </@linkPrimary.kw>
        </li>
      </#if>
      <li>${msg("loginTotpStep3")}</li>
      <li>${msg("loginTotpStep3DeviceName")}</li>
    </ol>
    <form action="${url.loginAction}" class="m-0 space-y-4" method="post">
      <div>
        <@inputPrimary.kw
          autocomplete="off"
          autofocus=true
          invalid=["totp"]
          name="totp"
          required=false
          type="text"
        >
          <@labelTotp.kw />
        </@inputPrimary.kw>
        <input name="totpSecret" type="hidden" value="${totp.totpSecret}">
        <#if mode??>
          <input name="mode" type="hidden" value="${mode}">
        </#if>
      </div>
      <div>
        <@inputPrimary.kw
          autocomplete="off"
          invalid=["userLabel"]
          name="userLabel"
          required=false
          type="text"
        >
          <@labelUserDevice.kw />
        </@inputPrimary.kw>
      </div>
      <#if isAppInitiatedAction??>
        <div class="flex flex-col pt-4 space-y-2">
          <@buttonPrimary.kw type="submit">
            ${msg("doSubmit")}
          </@buttonPrimary.kw>

          <@buttonSecondary.kw name="cancel-aia" type="submit">
            ${msg("doCancel")}
          </@buttonSecondary.kw>
        </div>
      <#else>
        <div class="pt-4">
          <@buttonPrimary.kw type="submit">
            ${msg("doSubmit")}
          </@buttonPrimary.kw>
        </div>
      </#if>
    </form>
  </#if>
</@layout.registrationLayout>
