<#import "/assets/providers/providers.ftl" as providerIcons>

<#macro kw providers=[]>
  <div class="relative flex py-4 text-gray-400 text-sm items-center">
      <div class="flex-grow border-t dark:border-zinc-700"></div>
      <span class="flex-shrink mx-4">${msg("identity-provider-login-label")}</span>
      <div class="flex-grow border-t dark:border-zinc-700"></div>
  </div>
  <div class="gap-4 grid grid-cols-3">
    <#list providers as provider>
      <#switch provider.alias>
        <#case "apple">
          <#assign colorClass="hover:bg-provider-apple/10">
          <#break>
        <#case "bitbucket">
          <#assign colorClass="hover:bg-provider-bitbucket/10">
          <#break>
        <#case "discord">
          <#assign colorClass="hover:bg-provider-discord/10">
          <#break>
        <#case "facebook">
          <#assign colorClass="hover:bg-provider-facebook/10">
          <#break>
        <#case "github">
          <#assign colorClass="hover:bg-provider-github/10">
          <#break>
        <#case "gitlab">
          <#assign colorClass="hover:bg-provider-gitlab/10">
          <#break>
        <#case "google">
          <#assign colorClass="hover:bg-provider-google/10">
          <#break>
        <#case "instagram">
          <#assign colorClass="hover:bg-provider-instagram/10">
          <#break>
        <#case "linkedin-openid-connect">
          <#assign colorClass="hover:bg-provider-linkedin/10">
          <#break>
        <#case "microsoft">
          <#assign colorClass="hover:bg-provider-microsoft/10">
          <#break>
        <#case "oidc">
          <#assign colorClass="hover:bg-provider-oidc/10">
          <#break>
        <#case "openshift-v3">
          <#assign colorClass="hover:bg-provider-openshift/10">
          <#break>
        <#case "openshift-v4">
          <#assign colorClass="hover:bg-provider-openshift/10">
          <#break>
        <#case "paypal">
          <#assign colorClass="hover:bg-provider-paypal/10">
          <#break>
        <#case "slack">
          <#assign colorClass="hover:bg-provider-slack/10">
          <#break>
        <#case "stackoverflow">
          <#assign colorClass="hover:bg-provider-stackoverflow/10">
          <#break>
        <#case "twitter">
          <#assign colorClass="hover:bg-provider-twitter/10">
          <#break>
        <#default>
          <#assign colorClass="hover:bg-secondary-100">
      </#switch>

      <div class="dark:bg-zinc-600 rounded-lg">
        <a
          class="${colorClass} dark:border-zinc-700 border border-secondary-200 flex justify-center py-2 rounded-lg hover:border-transparent"
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
      </div>
    </#list>
  </div>
</#macro>
