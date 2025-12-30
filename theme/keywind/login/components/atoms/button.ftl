<#macro kw color="" component="button" size="" rest...>
  <#switch color>
    <#case "primary">
      <#assign colorClass="bg-primary-600 dark:bg-primary-500 text-white focus:ring-primary-600 dark:focus:ring-primary-400 hover:bg-primary-700 dark:hover:bg-primary-600">
      <#break>
    <#case "secondary">
      <#assign colorClass="bg-secondary-100 dark:bg-gray-700 text-secondary-600 dark:text-gray-300 focus:ring-secondary-600 dark:focus:ring-gray-500 hover:bg-secondary-200 dark:hover:bg-gray-600 hover:text-secondary-900 dark:hover:text-white">
      <#break>
    <#default>
      <#assign colorClass="bg-primary-600 dark:bg-primary-500 text-white focus:ring-primary-600 dark:focus:ring-primary-400 hover:bg-primary-700 dark:hover:bg-primary-600">
  </#switch>

  <#switch size>
    <#case "medium">
      <#assign sizeClass="px-4 py-2 text-sm">
      <#break>
    <#case "small">
      <#assign sizeClass="px-2 py-1 text-xs">
      <#break>
    <#default>
      <#assign sizeClass="px-4 py-2 text-sm">
  </#switch>

  <${component}
    class="${colorClass} ${sizeClass} flex justify-center relative rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-offset-2 dark:focus:ring-offset-gray-800"

    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
