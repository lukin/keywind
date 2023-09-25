<#macro kw script="">
  <meta http-equiv="Content-Type" content="text/html charset=UTF-8">
  <meta name="robots" content="noindex, nofollow">
  <meta name="x-apple-disable-message-reformatting">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="format-detection" content="telephone=no, date=no, address=no, email=no, url=no">

  <#if properties.meta?has_content>
    <#list properties.meta?split(" ") as meta>
      <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}">
    </#list>
  </#if>
</#macro>
