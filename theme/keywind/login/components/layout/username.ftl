<#import "../button/icon.ftl" as buttonIcon >
<#import "../button/primary.ftl" as buttonPrimary>
<#import "../icon/external-link.ftl" as iconExternalLink>

<#macro kw>
  <#nested "show-username">
  <div class="mb-4 flex items-center justify-center">
    <div class="font-bold text-center">${auth.attemptedUsername}</div>
    <@buttonIcon.kw
      component="a"
      href="${url.loginRestartFlowUrl}"
      title="${msg('restartLoginTooltip')}"
    >
      <@iconExternalLink.kw />
    </@buttonIcon.kw>
  </div>
</#macro>
