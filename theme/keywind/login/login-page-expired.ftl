<#import "template.ftl" as layout>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout displayInfo=true displayMessage=false; section>
  <#if section="header">
    ${msg("pageExpiredTitle")}
  <#elseif section="info">
    <div class="space-y-4">
      <div class="flex space-x-1">
        <span>${msg("pageExpiredMsg1")}:</span>
        <@link.kw color="primary" href=url.loginRestartFlowUrl>
          ${msg("doClickHere")}
        </@link.kw>
      </div>
      <div class="flex space-x-1">
        <span>${msg("pageExpiredMsg2")}:</span>
        <@link.kw color="primary" href=url.loginAction>
          ${msg("doClickHere")}
        </@link.kw>
      </div>
    </div>
  </#if>
</@layout.registrationLayout>
