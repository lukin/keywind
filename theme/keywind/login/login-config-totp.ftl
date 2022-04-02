<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/button/secondary.ftl" as buttonSecondary>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/label/totp.ftl" as labelTotp>
<#import "components/label/userdevice.ftl" as labelUserDevice>
<#import "components/link/primary.ftl" as linkPrimary>

<@layout.registrationLayout
  displayRequiredFields=false
  displayMessage=!messagesPerField.existsError('totp','userLabel')
  ;
  section
>
  <#if section="header">
    ${msg("loginTotpTitle")}
  <#elseif section="form">
    <ol class="list-decimal pl-4 space-y-2">
      <li>
        <p>${msg("loginTotpStep1")}</p>

        <ul class="ml-6 list-disc space-y-1">
          <#list totp.policy.supportedApplications as app>
            <li>${app}</li>
          </#list>
        </ul>
      </li>

      <#if mode?? && mode = "manual">
        <li class="pt-2">
          <p>${msg("loginTotpManualStep2")}</p>
          <p class="font-bold text-xl">${totp.totpSecretEncoded}</p>
        </li>
        <li>
          <@linkPrimary.kw href=totp.qrUrl>
            ${msg("loginTotpScanBarcode")}
          </@linkPrimary.kw>
        </li>
        <li>
          <p>${msg("loginTotpManualStep3")}</p>

          <ul class="ml-6 list-disc space-y-2">
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

          <img class="text-center mx-auto" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
          <p>
            <@linkPrimary.kw href=totp.manualUrl>
              ${msg("loginTotpUnableToScan")}
            </@linkPrimary.kw>
          </p>
        </li>
      </#if>
      <li>
        <p>${msg("loginTotpStep3")}</p>
      </li>
      <li>
        <p>${msg("loginTotpStep3DeviceName")}</p>
      </li>
    </ol>
    <form action="${url.loginAction}" class="m-0 space-y-4" method="post">
      <div>
        <@inputPrimary.kw
          autocomplete="off"
          autofocus=true
          invalid=["totp"]
          name="totp"
          type="text"
          id="totp"
        >
          <@labelTotp.kw />
        </@inputPrimary.kw>
        <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
        <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
      </div>

      <div>
        <@inputPrimary.kw
          autocomplete="off"
          autofocus=true
          invalid=["userLabel"]
          name="userLabel"
          type="text"
          id="totp"
        >
          <@labelUserDevice.kw />
        </@inputPrimary.kw>
      </div>

      <#if isAppInitiatedAction??>
        <div class="py-2 flex flex-col space-y-1">
          <@buttonPrimary.kw
            type="submit"
            value=msg("doSubmit")
          >
            ${msg("doSubmit")}
          </@buttonPrimary.kw>

          <@buttonSecondary.kw
            type="submit"
            value="true"
          >
            ${msg("doCancel")}
          </@buttonSecondary.kw>
        </div>
      <#else>
        <div class="py-2">
          <@buttonPrimary.kw
            type="submit"
            value=msg("doSubmit")
          >
            ${msg("doSubmit")}
          </@buttonPrimary.kw>
        </div>
      </#if>
    </form>
  </#if>
</@layout.registrationLayout>
