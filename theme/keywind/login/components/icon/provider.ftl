<#import "./provider/bitbucket.ftl" as bitbucketIcon>
<#import "./provider/facebook.ftl" as facebookIcon>
<#import "./provider/github.ftl" as githubIcon>
<#import "./provider/gitlab.ftl" as gitlabIcon>
<#import "./provider/google.ftl" as googleIcon>
<#import "./provider/instagram.ftl" as instagramIcon>
<#import "./provider/linkedin.ftl" as linkedinIcon>
<#import "./provider/microsoft.ftl" as microsoftIcon>
<#import "./provider/oidc.ftl" as oidcIcon>
<#import "./provider/openshift.ftl" as openshiftIcon>
<#import "./provider/paypal.ftl" as paypalIcon>
<#import "./provider/stackoverflow.ftl" as stackoverflowIcon>
<#import "./provider/twitter.ftl" as twitterIcon>

<#macro bitbucket>
  <@bitbucketIcon.kw />
</#macro>

<#macro facebook>
  <@facebookIcon.kw />
</#macro>

<#macro github>
  <@githubIcon.kw />
</#macro>

<#macro gitlab>
  <@gitlabIcon.kw />
</#macro>

<#macro google>
  <@googleIcon.kw />
</#macro>

<#macro instagram>
  <@instagramIcon.kw />
</#macro>

<#macro linkedin>
  <@linkedinIcon.kw />
</#macro>

<#macro microsoft>
  <@microsoftIcon.kw />
</#macro>

<#macro oidc>
  <@oidcIcon.kw />
</#macro>

<#macro "openshift-v3">
  <@openshiftIcon.kw />
</#macro>

<#macro "openshift-v4">
  <@openshiftIcon.kw />
</#macro>

<#macro paypal>
  <@paypalIcon.kw />
</#macro>

<#macro stackoverflow>
  <@stackoverflowIcon.kw />
</#macro>

<#macro twitter>
  <@twitterIcon.kw />
</#macro>
