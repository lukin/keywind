<#macro kw component="span" rest...>
  <${component}
    class="ml-3 text-lg text-primary-600"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
