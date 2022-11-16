<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/button/secondary.ftl" as buttonSecondary>
<#import "components/button/secondary-small.ftl" as buttonSecondarySmall>
<#import "components/checkbox/primary.ftl" as checkboxPrimary>

<@layout.registrationLayout; section>

<#if section = "header">
    ${kcSanitize(msg("recovery-code-config-header"))}
<#elseif section = "form">

    <!-- warning -->
    <div class="bg-orange-100 text-orange-600 p-4 rounded-lg text-sm" role="alert">
        <p class="font-bold my-2">${kcSanitize(msg("recovery-code-config-warning-title"))}</p>
        <span>${kcSanitize(msg("recovery-code-config-warning-message"))}</span>
    </div>

    <ol class="font-mono kc-recovery-codes-list" id="kc-recovery-codes-list">
        <#list recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesList as code>
            <li><span class="font-bold">${code?counter}:</span> ${code[0..3]}-${code[4..7]}-${code[8..]}</li>
        </#list>
    </ol>

    <!-- actions -->
    <div class="flex items-stretch space-x-4 mb-4">
        <@buttonSecondarySmall.kw type="button" id="printRecoveryCodes">
          ${kcSanitize(msg("recovery-codes-print"))}
        <@buttonSecondarySmall.kw type="button" id="downloadRecoveryCodes">
          ${kcSanitize(msg("recovery-codes-download"))}
        </@buttonSecondarySmall.kw>
        <@buttonSecondarySmall.kw type="button" id="copyRecoveryCodes">
          ${kcSanitize(msg("recovery-codes-copy"))}
        </@buttonSecondarySmall.kw>
    </div>

    <form action="${url.loginAction}" class="m-0 space-y-4m" method="post">
        <input type="hidden" name="generatedRecoveryAuthnCodes" value="${recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesAsString}" />
        <input type="hidden" name="generatedAt" value="${recoveryAuthnCodesConfigBean.generatedAt?c}" />
        <input type="hidden" id="userLabel" name="userLabel" value="${msg("recovery-codes-label-default")}" />

        <!-- confirmation checkbox -->
        <@checkboxPrimary.kw id="kcRecoveryCodesConfirmationCheck" name="kcRecoveryCodesConfirmationCheck" required="required">
          ${kcSanitize(msg("recovery-codes-confirmation-message"))}
        </@checkboxPrimary.kw>

        <div class="flex flex-col space-y-2 mt-4">
            <#if isAppInitiatedAction??>
                <@buttonPrimary.kw type="submit" id="saveRecoveryAuthnCodesBtn">
                  ${kcSanitize(msg("recovery-codes-action-complete"))}
                </@buttonPrimary.kw>

                <@buttonSecondary.kw type="submit" id="cancelRecoveryAuthnCodesBtn" name="cancel-aia" value="true" onclick="document.getElementById('kcRecoveryCodesConfirmationCheck').required=false;return true;">
                  ${kcSanitize(msg("recovery-codes-action-cancel"))}
                </@buttonSecondary.kw>
            <#else>
                <@buttonPrimary.kw type="submit" id="saveRecoveryAuthnCodesBtn">
                  ${kcSanitize(msg("recovery-codes-action-complete"))}
                </@buttonPrimary.kw>
            </#if>
        </div>
    </form>

    <script>
        /* copy recovery codes  */
        function copyRecoveryCodes() {
            var tmpTextarea = document.createElement("textarea");
            var codes = document.getElementById("kc-recovery-codes-list").getElementsByTagName("li");
            for (i = 0; i < codes.length; i++) {
                tmpTextarea.value = tmpTextarea.value + codes[i].innerText + "\n";
            }
            document.body.appendChild(tmpTextarea);
            tmpTextarea.select();
            document.execCommand("copy");
            document.body.removeChild(tmpTextarea);
        }

        var copyButton = document.getElementById("copyRecoveryCodes");
        copyButton && copyButton.addEventListener("click", function () {
            copyRecoveryCodes();
        });

        /* download recovery codes  */
        function formatCurrentDateTime() {
            var dt = new Date();
            var options = {
                month: 'long',
                day: 'numeric',
                year: 'numeric',
                hour: 'numeric',
                minute: 'numeric',
                timeZoneName: 'short'
            };

            return dt.toLocaleString('en-US', options);
        }

        function parseRecoveryCodeList() {
            var recoveryCodes = document.querySelectorAll(".kc-recovery-codes-list li");
            var recoveryCodeList = "";

            for (var i = 0; i < recoveryCodes.length; i++) {
                var recoveryCodeLiElement = recoveryCodes[i].innerText;
                recoveryCodeList += recoveryCodeLiElement + "\r\n";
            }

            return recoveryCodeList;
        }

        function buildDownloadContent() {
            var recoveryCodeList = parseRecoveryCodeList();
            var dt = new Date();
            var options = {
                month: 'long',
                day: 'numeric',
                year: 'numeric',
                hour: 'numeric',
                minute: 'numeric',
                timeZoneName: 'short'
            };

            return fileBodyContent =
                "${msg("recovery-codes-download-file-header")}\n\n" +
                recoveryCodeList + "\n" +
                "${msg("recovery-codes-download-file-description")}\n\n" +
                "${msg("recovery-codes-download-file-date")} " + formatCurrentDateTime();
        }

        function setUpDownloadLinkAndDownload(filename, text) {
            var el = document.createElement('a');
            el.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
            el.setAttribute('download', filename);
            el.style.display = 'none';
            document.body.appendChild(el);
            el.click();
            document.body.removeChild(el);
        }

        function downloadRecoveryCodes() {
            setUpDownloadLinkAndDownload('kc-download-recovery-codes.txt', buildDownloadContent());
        }

        var downloadButton = document.getElementById("downloadRecoveryCodes");
        downloadButton && downloadButton.addEventListener("click", downloadRecoveryCodes);

        /* print recovery codes */
        function buildPrintContent() {
            var recoveryCodeListHTML = document.getElementById('kc-recovery-codes-list').innerHTML;
            var styles =
                `@page { size: auto;  margin-top: 0; }
                body { width: 480px; }
                div { list-style-type: none; font-family: monospace }
                p:first-of-type { margin-top: 48px }`

            return printFileContent =
                "<html><style>" + styles + "</style><body>" +
                "<title>kc-download-recovery-codes</title>" +
                "<p>${msg("recovery-codes-download-file-header")}</p>" +
                "<div>" + recoveryCodeListHTML + "</div>" +
                "<p>${msg("recovery-codes-download-file-description")}</p>" +
                "<p>${msg("recovery-codes-download-file-date")} " + formatCurrentDateTime() + "</p>" +
                "</body></html>";
        }

        function printRecoveryCodes() {
            var w = window.open();
            w.document.write(buildPrintContent());
            w.print();
            //w.close();
        }

        var printButton = document.getElementById("printRecoveryCodes");
        printButton && printButton.addEventListener("click", printRecoveryCodes);
    </script>
</#if>
</@layout.registrationLayout>
