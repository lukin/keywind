<#macro kw color="">
  <#switch color>
    <#case "error">
      <#assign colorClass="bg-red-100 dark:bg-red-900/30 text-red-600 dark:text-red-400">
      <#break>
    <#case "info">
      <#assign colorClass="bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400">
      <#break>
    <#case "success">
      <#assign colorClass="bg-green-100 dark:bg-green-900/30 text-green-600 dark:text-green-400">
      <#break>
    <#case "warning">
      <#assign colorClass="bg-orange-100 dark:bg-orange-900/30 text-orange-600 dark:text-orange-400">
      <#break>
    <#default>
      <#assign colorClass="bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400">
  </#switch>

  <div class="${colorClass} p-4 rounded-lg text-sm" role="alert">
    <#nested>
  </div>
</#macro>
