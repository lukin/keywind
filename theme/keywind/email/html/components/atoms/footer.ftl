<#macro kw>
  <table class="w-full mt-4" style="margin-top: 16px; width: 100%;">
    <tr>
      <td>
        <table>
          <tr>
            <td>
              <table>
                <tr>
                  <td class="font-semibold" style="font-weight: 600;">
                    This email was sent to <a href="mailto:${user.email!" "}" class="text-blue-600 hover:underline dark:text-blue-400" target="_blank" style="color: #2563eb;">${user.email!""}</a>.
                  </td>
                </tr>
                <tr>
                  <td class="h-0.5" style="height: 2px;"></td>
                </tr>
                <tr>
                  <td class="text-sm font-semibold opacity-50" style="font-size: 14px; font-weight: 600; opacity: 0.5;">
                    If you'd rather not receive this kind of email, you can <a href="#" class="text-blue-600 hover:underline dark:text-blue-400" style="color: #2563eb;">unsubscribe</a> or <a href="#" class="text-blue-600 hover:underline dark:text-blue-400" style="color: #2563eb;">manage your email preferences</a>.
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>

      <td class="text-right text-sm opacity-50" style="text-align: right; font-size: 14px; opacity: 0.5;">
        © ${.now?string('yyyy')} ${kcSanitize(realmName!"")}.
      </td>
    </tr>
  </table>
</#macro>
