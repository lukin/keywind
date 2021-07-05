<#macro kw component="span" rest...>
  <${component}
    class="absolute left-0 ml-3 text-lg"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
