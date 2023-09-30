<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout displayMessage=false; section>
  <#if section = "header">
    <#if messageHeader??>
      ${messageHeader}
    <#else>
      ${message.summary}
    </#if>
  <#elseif section = "form">
    <div>
      <p>${message.summary}<#if requiredActions??><#list requiredActions>: <b><#items as reqActionItem>${kcSanitize(msg("requiredAction.${reqActionItem}"))?no_esc}<#sep>, </#items></b></#list><#else></#if></p>
      <#if skipLink??>
      <#else>
        <#if pageRedirectUri?has_content>
          <p class="mt-4">
            <@button.kw component="a" color="primary" href="${pageRedirectUri}">${kcSanitize(msg("backToApplication"))?no_esc}</@button.kw>
          </p>
        <#elseif actionUri?has_content>
          <p class="mt-4">
            <@button.kw component="a" color="primary" href="${actionUri}">${kcSanitize(msg("proceedWithAction"))?no_esc}</@button.kw>
          </p>
        <#elseif (client.baseUrl)?has_content>
          <p class="mt-4">
            <@link.kw color="secondary" size="small" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</@link.kw>
          </p>
        </#if>
      </#if>
    </div>
  </#if>
</@layout.registrationLayout>
