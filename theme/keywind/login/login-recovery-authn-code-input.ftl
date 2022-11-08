<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/input/primary.ftl" as inputPrimary>

<@layout.registrationLayout; section>
<#if section="header">
    ${kcSanitize(msg("auth-recovery-code-header"))}
<#elseif section = "form">
    <form class="m-0 space-y-4" action="${url.loginAction}" method="post">
        <@inputPrimary.kw
          autocomplete="off"
          autofocus=true
          invalid=["firstName"]
          name="recoveryCodeInput"
          type="text"
          value=(register.formData.firstName)!''
        >
          ${msg("auth-recovery-code-prompt", recoveryAuthnCodesInputBean.codeNumber?c)}
        </@inputPrimary.kw>

        <@buttonPrimary.kw type="submit" name="login">
          ${kcSanitize(msg("doLogIn"))}
        </@buttonPrimary.kw>
    </form>
</#if>
</@layout.registrationLayout>
