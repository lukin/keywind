<#import "../atoms/checkbox.ftl" as checkbox>

<#macro logoutOtherSessions>
  <@checkbox.kw
    name="logout-sessions"
    label=msg("logoutOtherSessions")
    checked=true
    value="on"
  />
</#macro>
