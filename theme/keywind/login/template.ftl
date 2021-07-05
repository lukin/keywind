<#import "components/document.ftl" as document>
<#import "components/layout/alerts.ftl" as alerts>
<#import "components/layout/another-way.ftl" as anotherWay>
<#import "components/layout/card.ftl" as card>
<#import "components/layout/card-footer.ftl" as cardFooter>
<#import "components/layout/card-header.ftl" as cardHeader>
<#import "components/layout/card-main.ftl" as cardMain>
<#import "components/layout/container.ftl" as container>
<#import "components/layout/locales.ftl" as locales>
<#import "components/layout/nav.ftl" as nav>
<#import "components/layout/required-fields.ftl" as requiredFields>
<#import "components/layout/title.ftl" as title>
<#import "components/layout/subtitle.ftl" as subtitle>
<#import "components/layout/username.ftl" as username>

<#macro
  registrationLayout
  displayInfo=false
  displayMessage=true
  displayRequiredFields=false
  showAnotherWayIfPresent=true
>
  <html>
    <head>
      <@document.kw />
    </head>
    <body>
      <@container.kw>
        <@card.kw>
          <@cardHeader.kw>
            <@title.kw />
            <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
              <@subtitle.kw>
                <#nested "header">
              </@subtitle.kw>
            <#else>
              <@username.kw />
            </#if>
          </@cardHeader.kw>
          <@cardMain.kw>
            <#if displayMessage && message?has_content && (message.type != "warning" || !isAppInitiatedAction??)>
              <@alerts.kw />
            </#if>
            <#nested "form">
            <#if displayRequiredFields>
              <@requiredFields.kw />
            </#if>
            <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
              <@anotherWay.kw />
            </#if>
          </@cardMain.kw>
          <#if displayInfo>
            <@cardFooter.kw>
              <#nested "info">
            </@cardFooter.kw>
          </#if>
        </@card.kw>
        <@nav.kw>
          <#nested "nav">
          <#if realm.internationalizationEnabled && locale.supported?size gt 1>
            <@locales.kw />
          </#if>
        </@nav.kw>
      </@container.kw>
    </body>
  </html>
</#macro>
