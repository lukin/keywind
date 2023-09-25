<#macro kw script="">
  <meta charset="utf-8">
  <meta name="robots" content="noindex, nofollow">
  <meta name="x-apple-disable-message-reformatting">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <#if properties.meta?has_content>
    <#list properties.meta?split(" ") as meta>
      <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}">
    </#list>
  </#if>
</#macro>
