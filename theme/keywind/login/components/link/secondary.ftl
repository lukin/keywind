<#macro kw component="a" rest...>
  <${component}
    class="text-gray-600 hover:text-black"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
