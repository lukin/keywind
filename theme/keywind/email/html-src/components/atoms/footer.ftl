<#macro kw>
  <table class="w-full mt-4">
    <tr>
      <td>
        <table>
          <tr>
            <td>
              <table>
                <tr>
                  <td class="font-semibold">
                    This email was sent to <a href="mailto:${user.email!""}" class="text-blue-600 hover:underline dark:text-blue-400" target="_blank">${user.email!""}</a>.
                  </td>
                </tr>
                <tr>
                  <td class="h-0.5"></td>
                </tr>
                <tr>
                  <td class="text-sm font-semibold opacity-50">
                    If you'd rather not receive this kind of email, you can <a href="#" class="text-blue-600 hover:underline dark:text-blue-400">unsubscribe</a> or <a href="#" class="text-blue-600 hover:underline dark:text-blue-400">manage your email preferences</a>.
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>

      <td class="text-right text-sm opacity-50">
        © ${.now?string('yyyy')} ${kcSanitize(realmName!"")}.
      </td>
    </tr>
  </table>
</#macro>
