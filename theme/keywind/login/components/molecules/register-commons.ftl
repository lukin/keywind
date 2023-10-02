<#import "../atoms/input.ftl" as input>
<#macro termsAcceptance>
    <#if termsAcceptanceRequired??>
      <div>
          ${msg("termsTitle")}
          <div class="text-sm opacity-80">
              ${kcSanitize(msg("termsText"))?no_esc}
          </div>
      </div>
      <@input.kw
        type="checkbox"
        id="termsAccepted"
        name="termsAccepted"
        label=msg("acceptTerms")
        invalid=messagesPerField.existsError('termsAccepted')
        message=kcSanitize(messagesPerField.get('termsAccepted'))?no_esc
        required=true
        />
    </#if>
</#macro>
