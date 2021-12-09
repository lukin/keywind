<#import "template.ftl" as layout>
<#import "components/provider.ftl" as provider>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/checkbox/primary.ftl" as checkboxPrimary>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/label/username.ftl" as labelUsername>
<#import "components/link/primary.ftl" as linkPrimary>

<@layout.registrationLayout
  displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??
  displayMessage=!messagesPerField.existsError("username", "password")
  ;
  section
>
  <#if section="header">
    ${msg("loginAccountTitle")}
  <#elseif section="form">
    <#if realm.password>
      <form
        action="${url.loginAction}"
        class="m-0 space-y-4"
        method="post"
        onsubmit="login.disabled = true; return true;"
      >
        <input
          name="credentialId"
          type="hidden"
          value="<#if auth.selectedCredential?has_content>${auth.selectedCredential}</#if>"
        >
        <div>
          <@inputPrimary.kw
            autocomplete=realm.loginWithEmailAllowed?string("email", "username")
            autofocus=true
            disabled=usernameEditDisabled??
            invalid=["username", "password"]
            name="username"
            type="text"
            value=(login.username)!''
          >
            <@labelUsername.kw />
          </@inputPrimary.kw>
        </div>
        <div>
          <@inputPrimary.kw
            invalid=["username", "password"]
            message=false
            name="password"
            type="password"
          >
            ${msg("password")}
          </@inputPrimary.kw>
        </div>
        <div class="flex items-center justify-between">
          <#if realm.rememberMe && !usernameEditDisabled??>
            <@checkboxPrimary.kw checked=login.rememberMe?? name="rememberMe">
              ${msg("rememberMe")}
            </@checkboxPrimary.kw>
          </#if>
          <#if realm.resetPasswordAllowed>
            <@linkPrimary.kw href=url.loginResetCredentialsUrl>
              <span class="text-sm">${msg("doForgotPassword")}</span>
            </@linkPrimary.kw>
          </#if>
        </div>
        <div class="pt-4">
          <@buttonPrimary.kw name="login" type="submit">
            ${msg("doLogIn")}
          </@buttonPrimary.kw>
        </div>
      </form>
    </#if>
    <#if realm.password && social.providers??>
      <@provider.kw />
    </#if>
  <#elseif section="info">
    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
      <div class="text-center">
        ${msg("noAccount")}
        <@linkPrimary.kw href=url.registrationUrl>
          ${msg("doRegister")}
        </@linkPrimary.kw>
      </div>
    </#if>
  </#if>
</@layout.registrationLayout>
