<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>

<@layout.registrationLayout; section>
  <#if section = "header">
    ${msg("oauth2DeviceVerificationTitle")}
  <#elseif section = "form">
    <@form.kw action=url.oauth2DeviceVerificationAction method="post">
      <@input.kw
        autocomplete="off"
        autofocus=true
        label=msg("verifyOAuth2DeviceUserCode")
        name="device_user_code"
        type="text"
        dir="ltr"
      />

      <@buttonGroup.kw>
        <@button.kw color="primary" name="submitAction" type="submit">
          ${msg("doSubmit")}
        </@button.kw>
      </@buttonGroup.kw>
    </@form.kw>
  </#if>
</@layout.registrationLayout>
