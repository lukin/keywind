<#import "../button/primary.ftl" as buttonPrimary>

<#macro kw>
  <form action="${url.loginAction}" class="flex justify-center" method="post">
    <input name="tryAnotherWay" type="hidden" value="on"/>
    <@buttonPrimary.kw type="submit">
      ${msg("doTryAnotherWay")}
    </@buttonPrimary.kw>
  </form>
</#macro>
