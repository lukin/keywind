<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>

<@layout.registrationLayout; section>
  <#if section="header">
    ${msg("confirmLinkIdpTitle")}
  <#elseif section="form">
    <form action="${url.loginAction}" class="m-0 space-y-4" method="post">
      <div>
        <@buttonPrimary.kw name="submitAction" type="submit" value="updateProfile">
          ${msg("confirmLinkIdpReviewProfile")}
        </@buttonPrimary.kw>
      </div>
      <div>
        <@buttonPrimary.kw name="submitAction" type="submit" value="linkAccount">
          ${msg("confirmLinkIdpContinue", idpDisplayName)}
        </@buttonPrimary.kw>
      </div>
    </form>
  </#if>
</@layout.registrationLayout>
