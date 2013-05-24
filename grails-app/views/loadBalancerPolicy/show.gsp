<%--

    Copyright 2013 Netflix, Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Load Balancer Policy</title>
</head>
<body>
  <div class="body">
    <h1>Load Balancer Policy Details</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${cmd}">
      <div class="errors">
        <g:renderErrors bean="${cmd}" as="list"/>
      </div>
    </g:hasErrors>
    <div class="buttons">
      %{--<g:form>--}%
        %{--<input type="hidden" name="name" value="${loadBalancer.loadBalancerName}"/>--}%
        %{--<g:link class="edit" action="edit" params="[id: loadBalancer.loadBalancerName]">Edit Load Balancer</g:link>--}%
        %{--<g:buttonSubmit class="delete" action="delete" value="Delete Load Balancer"--}%
                        %{--data-warning="Really delete Load Balancer '${loadBalancer.loadBalancerName}'?" />--}%
        %{--<g:link class="create" action="prepareListener" params="[id: loadBalancer.loadBalancerName]">Add Listener</g:link>--}%
      %{--</g:form>--}%
    </div>
    <div>
      <table>
        <tbody>
        <tr class="prop">
          <td class="name">Load Balancer:</td>
          <td class="value"><g:linkObject type="loadBalancer" name="${loadBalancerName}"/></td>
        </tr>
        <tr class="prop">
          <td class="name">Policy Name:</td>
          <td class="value">${policy.policyName}</td>
        </tr>
        <tr class="prop">
          <td class="name">Policy Type:</td>
          <td class="value">${policy.policyTypeName}</td>
        </tr>
        <tr class="prop">
          <td class="name">Attributes:</td>
          <td class="value">
            <table>
              <g:each var="attribute" in="${policy.policyAttributeDescriptions.sort { it.attributeName }}">
                <tr class="prop">
                  <td><pre>${attribute.attributeName}</pre></td>
                  <td>=</td>
                  <td><pre>${attribute.attributeValue}</pre></td>
                </tr>
              </g:each>
            </table>
          </td>
        </tr>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>
