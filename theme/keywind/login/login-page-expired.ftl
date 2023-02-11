<#import "template.ftl" as layout>
<#import "components/atoms/link.ftl" as link>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>

<@layout.registrationLayout displayInfo=true displayMessage=false; section>
  <#if section="header">
    ${msg("pageExpiredTitle")}
  <#elseif section="info">
    <div class="space-y-4">
      <div>
        ${msg("pageExpiredMsg1")}:
        <@buttonGroup.kw>
          <@button.kw component="a" color="primary" href=url.loginRestartFlowUrl>
            ${msg("doClickHere")}
          </@button.kw>
        </@buttonGroup.kw>
      </div>
      <div>
        ${msg("pageExpiredMsg2")}:
        <@buttonGroup.kw>
          <@button.kw component="a" color="secondary" href=url.loginAction>
            ${msg("doClickHere")}
          </@button.kw>
        </@buttonGroup.kw>
      </div>
    </div>
  </#if>
</@layout.registrationLayout>
