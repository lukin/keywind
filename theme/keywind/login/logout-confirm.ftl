<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/link/secondary.ftl" as linkSecondary>

<@layout.registrationLayout; section>
  <#if section = "header">
    ${msg("logoutConfirmTitle")}
  <#elseif section = "form">
    <p>${msg("logoutConfirmHeader")}</p>
    <form action="${url.logoutConfirmAction}" class="m-0 space-y-4" method="post">
      <input name="session_code" type="hidden" value="${logoutConfirm.code}">
      <@buttonPrimary.kw name="confirmLogout" type="submit" value="${msg('doLogout')}">
        ${msg("doLogout")}
      </@buttonPrimary.kw>
    </form>
    <#if !logoutConfirm.skipLink>
      <#if (client.baseUrl)?has_content>
        <@linkSecondary.kw href=client.baseUrl>
          <span class="text-sm">${kcSanitize(msg("backToApplication"))?no_esc}</span>
        </@linkSecondary.kw>
      </#if>
    </#if>
  </#if>
</@layout.registrationLayout>
