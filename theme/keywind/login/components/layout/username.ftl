<#import "../button/icon.ftl" as buttonIcon >
<#import "../button/primary.ftl" as buttonPrimary>
<#import "../icon/external-link.ftl" as iconExternalLink>

<#macro kw>
  <#nested "show-username">
  <div class="mb-4">
    <div class="font-bold mb-2 text-center">${auth.attemptedUsername}</div>
    <@buttonPrimary.kw component="a" href="${url.loginRestartFlowUrl}">
      <@buttonIcon.kw>
        <@iconExternalLink.kw />
      </@buttonIcon.kw>
      ${msg("restartLoginTooltip")}
    </@buttonPrimary.kw>
  </div>
</#macro>
