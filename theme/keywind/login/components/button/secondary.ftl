<#macro kw component="button" rest...>
  <${component}
    class="bg-transparent flex justify-center px-4 py-3 relative rounded-lg font-bold text-gray-600 w-full focus:outline-none hover:text-black"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
