<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>

<@layout.registrationLayout displayInfo=true displayMessage=false; section>
  <#if section="header">
    ${msg("errorTitle")}
  <#elseif section="form">
    ${kcSanitize(message.summary)}
  <#elseif section="info">
    <@buttonGroup.kw>
      <@button.kw component="a" color="primary" href=client.baseUrl>
        ${kcSanitize(msg("backToApplication"))?no_esc}
      </@button.kw>
      <@button.kw component="a" color="secondary" href=url.loginUrl>
        ${kcSanitize(msg("backToLogin"))?no_esc}
      </@button.kw>
    </@buttonGroup.kw>
  </#if>
</@layout.registrationLayout>
