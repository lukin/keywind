<#import "/assets/providers/providers.ftl" as providerIcons>

<#macro kw providers=[]>
  <div class="pt-4 separate text-secondary-600 dark:text-secondary-100 text-sm">
    ${msg("identity-provider-login-label")}
  </div>
  <div class="gap-4 grid grid-cols-3">
    <#list providers as provider>
      <#switch provider.alias>
        <#case "apple">
          <#assign colorClass="hover:bg-provider-apple/10 dark:hover:bg-provider-apple/50">
          <#break>
        <#case "bitbucket">
          <#assign colorClass="hover:bg-provider-bitbucket/10 dark:hover:bg-provider-bitbucket/50">
          <#break>
        <#case "discord">
          <#assign colorClass="hover:bg-provider-discord/10 dark:hover:bg-provider-discord/50">
          <#break>
        <#case "facebook">
          <#assign colorClass="hover:bg-provider-facebook/10 dark:hover:bg-provider-facebook/50">
          <#break>
        <#case "github">
          <#assign colorClass="hover:bg-provider-github/10 dark:hover:bg-provider-github/50">
          <#break>
        <#case "gitlab">
          <#assign colorClass="hover:bg-provider-gitlab/10 dark:hover:bg-provider-gitlab/50">
          <#break>
        <#case "google">
          <#assign colorClass="hover:bg-provider-google/10 dark:hover:bg-provider-google/50">
          <#break>
        <#case "instagram">
          <#assign colorClass="hover:bg-provider-instagram/10 dark:hover:bg-provider-instagram/50">
          <#break>
        <#case "linkedin-openid-connect">
          <#assign colorClass="hover:bg-provider-linkedin/10 dark:hover:bg-provider-linkedin/50">
          <#break>
        <#case "microsoft">
          <#assign colorClass="hover:bg-provider-microsoft/10 dark:hover:bg-provider-microsoft/50">
          <#break>
        <#case "oidc">
          <#assign colorClass="hover:bg-provider-oidc/10 dark:hover:bg-provider-oidc/50">
          <#break>
        <#case "openshift-v3">
          <#assign colorClass="hover:bg-provider-openshift/10 dark:hover:bg-provider-openshift/50">
          <#break>
        <#case "openshift-v4">
          <#assign colorClass="hover:bg-provider-openshift/10 dark:hover:bg-provider-openshift/50">
          <#break>
        <#case "paypal">
          <#assign colorClass="hover:bg-provider-paypal/10 dark:hover:bg-provider-paypal/50">
          <#break>
        <#case "slack">
          <#assign colorClass="hover:bg-provider-slack/10 dark:hover:bg-provider-slack/50">
          <#break>
        <#case "stackoverflow">
          <#assign colorClass="hover:bg-provider-stackoverflow/10 dark:hover:bg-provider-stackoverflow/50">
          <#break>
        <#case "twitter">
          <#assign colorClass="hover:bg-provider-twitter/10 dark:hover:bg-provider-twitter/50">
          <#break>
        <#default>
          <#assign colorClass="hover:bg-secondary-100 dark:hover:bg-secondary-400">
      </#switch>

      <a
        class="${colorClass} border border-secondary-200 flex justify-center py-2 rounded-lg hover:border-transparent"
        data-provider="${provider.alias}"
        href="${provider.loginUrl}"
        type="button"
      >
        <#if providerIcons[provider.alias]??>
          <div class="h-6 w-6">
            <@providerIcons[provider.alias] />
          </div>
        <#else>
          ${provider.displayName!}
        </#if>
      </a>
    </#list>
  </div>
</#macro>
