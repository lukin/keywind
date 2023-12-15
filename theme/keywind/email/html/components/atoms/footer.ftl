<#macro kw>
  <table cellpadding="0" cellspacing="0" border="0" align="right" class="w-full mt-4 text-right text-sm opacity-80" style="margin-top: 16px; width: 100%; text-align: right; font-size: 14px; opacity: 0.8;">
    <tr class="text-right text-sm opacity-80" style="text-align: right; font-size: 14px; opacity: 0.8;">
      <td align="right" class="text-right text-sm opacity-80" style="text-align: right; font-size: 14px; opacity: 0.8;">
        © ${.now?string('yyyy')} ${kcSanitize(realmName!"")}.
      </td>
    </tr>
  </table>
</#macro>
