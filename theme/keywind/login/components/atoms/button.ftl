<#macro kw color="" component="button" size="" rest...>
  <#switch color>
    <#case "primary">
      <#assign colorClass="bg-primary-600 text-white dark:text-secondary-100 focus:ring-primary-600 hover:bg-primary-700">
      <#break>
    <#case "secondary">
      <#assign colorClass="bg-secondary-100 dark:bg-secondary-800 text-secondary-600 dark:text-secondary-100 focus:ring-secondary-600 hover:bg-secondary-200 dark:hover:bg-secondary-900 hover:text-secondary-900 dark:hover:text-secondary-100">
      <#break>
    <#default>
      <#assign colorClass="bg-primary-600 text-white dark:text-secondary-100 focus:ring-primary-600 hover:bg-primary-700">
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
    class="${colorClass} ${sizeClass} flex justify-center relative rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-offset-2"

    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
