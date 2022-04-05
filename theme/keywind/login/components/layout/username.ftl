<#import "../icon/external-link.ftl" as iconExternalLink>
<#import "../link/primary.ftl" as linkPrimary>

<#macro kw>
  <#nested "show-username">
  <div class="flex items-center justify-center mb-4 space-x-2">
    <b>${auth.attemptedUsername}</b>
    <@linkPrimary.kw
      href="${url.loginRestartFlowUrl}"
      title="${msg('restartLoginTooltip')}"
    >
      <@iconExternalLink.kw />
    </@linkPrimary.kw>
  </div>
</#macro>
