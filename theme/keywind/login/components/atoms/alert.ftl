<#macro kw color="">
  <#switch color>
    <#case "error">
      <#assign colorClass="bg-red-100 text-red-600 dark:bg-red-200 dark:text-red-700">
      <#break>
    <#case "info">
      <#assign colorClass="bg-blue-100 text-blue-600 dark:bg-blue-200 dark:text-blue-700">
      <#break>
    <#case "success">
      <#assign colorClass="bg-green-100 text-green-600 dark:bg-green-200 dark:text-green-700">
      <#break>
    <#case "warning">
      <#assign colorClass="bg-orange-100 text-orange-600 dark:bg-orange-200 dark:text-orange-700">
      <#break>
    <#default>
      <#assign colorClass="bg-blue-100 text-blue-600 dark:bg-blue-200 dark:text-blue-700">
  </#switch>

  <div class="${colorClass} px-4 py-3 rounded-lg text-sm" role="alert">
    <#nested>
  </div>
</#macro>
