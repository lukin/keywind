<#macro kw>
  <#switch message.type>
    <#case "error">
      <#assign color="bg-red-100 text-red-600">
    <#case "info">
      <#assign color="bg-blue-100 text-blue-600">
    <#case "success">
      <#assign color="bg-green-100 text-green-600">
    <#case "warning">
      <#assign color="bg-orange-100 text-orange-600">
    <#default>
      <#assign color="bg-blue-100 text-blue-600">
  </#switch>

  <div class="${color} p-4 rounded-lg text-sm" role="alert">
    <span>${kcSanitize(message.summary)?no_esc}</span>
  </div>
</#macro>
