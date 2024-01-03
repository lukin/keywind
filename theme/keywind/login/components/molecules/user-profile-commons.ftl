<#import "../atoms/checkbox.ftl" as checkbox>
<#import "../atoms/input.ftl" as input>
<#import "../atoms/radio.ftl" as radio>
<#import "../atoms/select.ftl" as select>
<#import "../atoms/textarea.ftl" as textarea>

<#macro userProfileFormFields>
	<#assign currentGroup="">

	<#list profile.attributes as attribute>

		<#assign groupName = attribute.group!"">
		<#if groupName != currentGroup>
			<#assign currentGroup=groupName>
			<#if currentGroup != "" >
				<div>
					<#assign groupDisplayHeader=attribute.groupDisplayHeader!"">
					<#if groupDisplayHeader != "">
						<#assign groupHeaderText=advancedMsg(attribute.groupDisplayHeader)!groupName>
					<#else>
						<#assign groupHeaderText=groupName>
					</#if>
					<div class="font-bold">
						<label id="header-${groupName}">${groupHeaderText}</label>
					</div>

					<#assign groupDisplayDescription=attribute.groupDisplayDescription!"">
					<#if groupDisplayDescription != "">
						<#assign groupDescriptionText=advancedMsg(attribute.groupDisplayDescription)!"">
						<div class="italic pl-1">
							<label id="description-${groupName}">${groupDescriptionText}</label>
						</div>
					</#if>
				</div>
			</#if>
		</#if>

		<#nested "beforeField" attribute>
		<#if attribute.annotations.inputHelperTextBefore??>
			<div class="${properties.kcInputHelperTextBeforeClass!}" id="form-help-text-before-${attribute.name}" aria-live="polite">${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextBefore))?no_esc}</div>
		</#if>
		<@inputFieldByType attribute=attribute/>
		<#if attribute.annotations.inputHelperTextAfter??>
			<div class="${properties.kcInputHelperTextAfterClass!}" id="form-help-text-after-${attribute.name}" aria-live="polite">${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextAfter))?no_esc}</div>
		</#if>
		<#nested "afterField" attribute>
	</#list>
</#macro>

<#macro inputFieldByType attribute>
	<#switch attribute.annotations.inputType!''>
	<#case 'textarea'>
		<@textareaTag attribute=attribute/>
		<#break>
	<#case 'select'>
	<#case 'multiselect'>
		<@selectTag attribute=attribute/>
		<#break>
	<#case 'select-radiobuttons'>
	<#case 'multiselect-checkboxes'>
		<@inputTagSelects attribute=attribute/>
		<#break>
	<#default>
		<@inputTag attribute=attribute/>
	</#switch>
</#macro>

<#macro inputTag attribute>
  <#assign type>
    <@inputTagType attribute=attribute />
  </#assign>
  <#assign label>
    <@labelText attribute=attribute />
  </#assign>
	<@input.kw
    type=type?markup_string
    name=attribute.name
    value=attribute.value!''
    required=attribute.required
		disabled=attribute.readOnly
    label=label?markup_string
		invalid=messagesPerField.existsError('${attribute.name}')
    message=kcSanitize(messagesPerField.getFirstError('${attribute.name}'))
		<#if attribute.autocomplete??>autocomplete="${attribute.autocomplete}"</#if>
		<#if attribute.annotations.inputTypePlaceholder??>placeholder="${attribute.annotations.inputTypePlaceholder}"</#if>
		<#if attribute.annotations.inputTypePattern??>pattern="${attribute.annotations.inputTypePattern}"</#if>
		<#if attribute.annotations.inputTypeSize??>size="${attribute.annotations.inputTypeSize}"</#if>
		<#if attribute.annotations.inputTypeMaxlength??>maxlength="${attribute.annotations.inputTypeMaxlength}"</#if>
		<#if attribute.annotations.inputTypeMinlength??>minlength="${attribute.annotations.inputTypeMinlength}"</#if>
		<#if attribute.annotations.inputTypeMax??>max="${attribute.annotations.inputTypeMax}"</#if>
		<#if attribute.annotations.inputTypeMin??>min="${attribute.annotations.inputTypeMin}"</#if>
		<#if attribute.annotations.inputTypeStep??>step="${attribute.annotations.inputTypeStep}"</#if>
	/>
</#macro>

<#macro inputTagType attribute>
	<#compress>
	<#if attribute.annotations.inputType??>
		<#if attribute.annotations.inputType?starts_with("html5-")>
			${attribute.annotations.inputType[6..]}
		<#else>
			${attribute.annotations.inputType}
		</#if>
	<#else>
	  text
	</#if>
	</#compress>
</#macro>

<#macro textareaTag attribute>
  <#assign label>
    <@labelText attribute=attribute />
  </#assign>
	<@textarea.kw
    name=attribute.name
    required=attribute.required
		disabled=attribute.readOnly
    label=label?markup_string
		invalid=messagesPerField.existsError('${attribute.name}')
    message=kcSanitize(messagesPerField.getFirstError('${attribute.name}'))
		<#if attribute.annotations.inputTypeCols??>cols="${attribute.annotations.inputTypeCols}"</#if>
		<#if attribute.annotations.inputTypeRows??>rows="${attribute.annotations.inputTypeRows}"</#if>
		<#if attribute.annotations.inputTypeMaxlength??>maxlength="${attribute.annotations.inputTypeMaxlength}"</#if>
	>${(attribute.value!'')}</@textarea.kw>
</#macro>

<#macro selectTag attribute>
  <#assign label>
    <@labelText attribute=attribute />
  </#assign>
	<@select.kw
    name=attribute.name
    required=attribute.required
		disabled=attribute.readOnly
    label=label?markup_string
		invalid=messagesPerField.existsError('${attribute.name}')
    message=kcSanitize(messagesPerField.getFirstError('${attribute.name}'))
		<#if attribute.annotations.inputType=='multiselect'>multiple</#if>
		<#if attribute.annotations.inputTypeSize??>size="${attribute.annotations.inputTypeSize}"</#if>
	>
	<#if attribute.annotations.inputType=='select'>
		<option value="">${label?markup_string}</option>
	</#if>

	<#if attribute.annotations.inputOptionsFromValidation?? && attribute.validators[attribute.annotations.inputOptionsFromValidation]?? && attribute.validators[attribute.annotations.inputOptionsFromValidation].options??>
		<#assign options=attribute.validators[attribute.annotations.inputOptionsFromValidation].options>
	<#elseif attribute.validators.options?? && attribute.validators.options.options??>
		<#assign options=attribute.validators.options.options>
	</#if>

	<#if options??>
		<#list options as option>
		<option value="${option}" <#if attribute.values?seq_contains(option)>selected</#if>><@selectOptionLabelText attribute=attribute option=option/></option>
		</#list>
	</#if>
	</@select.kw>
</#macro>

<#macro inputTagSelects attribute>
	<#if attribute.annotations.inputOptionsFromValidation?? && attribute.validators[attribute.annotations.inputOptionsFromValidation]?? && attribute.validators[attribute.annotations.inputOptionsFromValidation].options??>
		<#assign options=attribute.validators[attribute.annotations.inputOptionsFromValidation].options>
	<#elseif attribute.validators.options?? && attribute.validators.options.options??>
		<#assign options=attribute.validators.options.options>
	</#if>

  <label class="sr-only" for="${attribute.name}">
    <@labelText attribute=attribute />
  </label>

	<#if options??>
		<#list options as option>
      <#assign optionLabel>
        <@selectOptionLabelText attribute=attribute option=option/>
      </#assign>
      <#if attribute.annotations.inputType=='select-radiobuttons'>
        <@radio.kw
          id="${attribute.name}-${option}"
          name=attribute.name
          value=option
          disabled=attribute.readOnly
          label=optionLabel?markup_string
          invalid=messagesPerField.existsError('${attribute.name}')
          message=kcSanitize(messagesPerField.getFirstError('${attribute.name}'))
          checked=attribute.values?seq_contains(option)
        />
      <#else>
        <@checkbox.kw
          id="${attribute.name}-${option}"
          name=attribute.name
          value=option
          disabled=attribute.readOnly
          label=optionLabel?markup_string
          invalid=messagesPerField.existsError('${attribute.name}')
          message=kcSanitize(messagesPerField.getFirstError('${attribute.name}'))
          checked=attribute.values?seq_contains(option)
        />
      </#if>
		</#list>
	</#if>
</#macro>

<#macro selectOptionLabelText attribute option>
	<#compress>
	<#if attribute.annotations.inputOptionLabels??>
		${advancedMsg(attribute.annotations.inputOptionLabels[option]!option)}
	<#else>
		<#if attribute.annotations.inputOptionLabelsI18nPrefix??>
			${msg(attribute.annotations.inputOptionLabelsI18nPrefix + '.' + option)}
		<#else>
			${option}
		</#if>
	</#if>
	</#compress>
</#macro>

<#macro labelText attribute>
	<#compress>
    ${advancedMsg(attribute.displayName!'')} <#if attribute.required>*</#if>
	</#compress>
</#macro>
