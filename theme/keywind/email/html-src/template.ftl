<#import "document.ftl" as document>
<#import "components/atoms/background.ftl" as background>
<#import "components/atoms/body.ftl" as body>
<#import "components/atoms/card.ftl" as card>
<#import "components/atoms/container.ftl" as container>
<#import "components/atoms/footer.ftl" as footer>
<#import "components/atoms/header.ftl" as header>
<#import "components/atoms/main.ftl" as main>

<#macro emailLayout>
<!DOCTYPE html>
<html>
  <head>
    <@document.kw script=script />
  </head>
  <@body.kw>
    <@background.kw />
    <@container.kw>
      <@card.kw>
        <@header.kw />
        <@main.kw>
          <#nested>
        </@main.kw>
      </@card.kw>
    </@container.kw>
    <@footer.kw />
  </@body.kw>
</html>
</#macro>
