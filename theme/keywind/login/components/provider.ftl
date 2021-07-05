<#import "./socials.ftl" as socials>

<#macro kw>
  <div class="separate pt-4">${msg("identity-provider-login-label")}</div>
  <div class="flex <#if social.providers?size gt 3>justify-between<#else>justify-around</#if>">
    <#list social.providers as provider>
      <a
        class="text-5xl"
        data-provider="${provider.alias}"
        href="${provider.loginUrl}"
        title="${provider.displayName!}"
        type="button"
      >
        <#if provider.iconClasses?has_content>
          <i class="${provider.iconClasses!}"></i>
        <#else>
          <@socials[provider.alias] />
        </#if>
      </a>
    </#list>
  </div>
</#macro>
