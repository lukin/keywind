<#import "./icon/provider.ftl" as iconProvider>

<#macro kw>
  <div class="pt-4 separate text-secondary-600 text-sm">${msg("identity-provider-login-label")}</div>
  <div class="gap-4 grid grid-cols-3">
    <#list social.providers as provider>
      <#switch provider.alias>
        <#case "bitbucket">
          <#assign color="hover:bg-provider-bitbucket/10">
          <#break>
        <#case "facebook">
          <#assign color="hover:bg-provider-facebook/10">
          <#break>
        <#case "github">
          <#assign color="hover:bg-provider-github/10">
          <#break>
        <#case "gitlab">
          <#assign color="hover:bg-provider-gitlab/10">
          <#break>
        <#case "google">
          <#assign color="hover:bg-provider-google/10">
          <#break>
        <#case "instagram">
          <#assign color="hover:bg-provider-instagram/10">
          <#break>
        <#case "linkedin">
          <#assign color="hover:bg-provider-linkedin/10">
          <#break>
        <#case "microsoft">
          <#assign color="hover:bg-provider-microsoft/10">
          <#break>
        <#case "oidc">
          <#assign color="hover:bg-provider-oidc/10">
          <#break>
        <#case "openshift-v3">
          <#assign color="hover:bg-provider-openshift/10">
          <#break>
        <#case "openshift-v4">
          <#assign color="hover:bg-provider-openshift/10">
          <#break>
        <#case "paypal">
          <#assign color="hover:bg-provider-paypal/10">
          <#break>
        <#case "stackoverflow">
          <#assign color="hover:bg-provider-stackoverflow/10">
          <#break>
        <#case "twitter">
          <#assign color="hover:bg-provider-twitter/10">
          <#break>
        <#default>
          <#assign color="hover:bg-secondary-100">
      </#switch>

      <a
        class="border border-secondary-200 flex justify-center py-2 rounded-lg hover:border-transparent ${color}"
        data-provider="${provider.alias}"
        href="${provider.loginUrl}"
        type="button"
      >
        <#if iconProvider[provider.alias]??>
          <div class="h-6 w-6">
            <@iconProvider[provider.alias] />
          </div>
        <#else>
          ${provider.displayName!}
        </#if>
      </a>
    </#list>
  </div>
</#macro>
