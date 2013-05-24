<%--

    Copyright 2012 Netflix, Inc.

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
  <title>${loadBalancer.loadBalancerName} Load Balancer</title>
</head>
<body>
  <div class="body">
    <h1>Load Balancer Details</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${cmd}">
      <div class="errors">
        <g:renderErrors bean="${cmd}" as="list"/>
      </div>
    </g:hasErrors>
    <div class="buttons">
      <g:form>
        <input type="hidden" name="name" value="${loadBalancer.loadBalancerName}"/>
        <g:link class="edit" action="edit" params="[id: loadBalancer.loadBalancerName]">Edit Load Balancer</g:link>
        <g:buttonSubmit class="delete" action="delete" value="Delete Load Balancer"
                        data-warning="Really delete Load Balancer '${loadBalancer.loadBalancerName}'?" />
        <g:link class="create" action="prepareListener" params="[id: loadBalancer.loadBalancerName]">Prepare to Add Listener</g:link>
        <g:if test="${allowCrossZoneLoadBalancing}">
          <g:buttonSubmit class="crossZone" action="enableCrossZoneLoadBalancing" value="Enable Cross-Zone Load Balancing"/>
        </g:if>
      </g:form>
    </div>
    <div class="dialog">
      <table>
        <tbody>
        <tr class="prop">
          <td class="name">Name:</td>
          <td class="value">${loadBalancer.loadBalancerName}</td>
        </tr>
        <tr class="prop">
          <td class="name">DNS Name:</td>
          <td class="value">${loadBalancer.dNSName}</td>
        </tr>
        <tr class="prop">
          <td class="name">Availability Zones:</td>
          <td class="value">
            <g:each var="zone" in="${loadBalancer.availabilityZones.sort()}">
              <div><g:availabilityZone value="${zone}"/></div>
            </g:each>
          </td>
        </tr>
        <tr class="prop">
          <td class="name">VPC Purpose:</td>
          <td class="value">${subnetPurpose}</td>
        </tr>
        <tr class="prop">
          <td class="name">Subnets:</td>
          <td class="value">${loadBalancer.subnets}</td>
        </tr>
        <g:if test="${loadBalancer.policies.appCookieStickinessPolicies}">
          <tr class="prop">
            <td class="name">App Cookie Stickiness Policies:</td>
            <td class="value">
              <div class="list">
                <table class="sortable subitems">
                  <thead>
                  <tr>
                    <th>Policy Name</th>
                    <th>Cookie Name</th>
                    <th class="sorttable_nosort"></th>
                  </tr>
                  </thead>
                  <g:each var="policy" in="${loadBalancer.policies.appCookieStickinessPolicies.sort { it.policyName }}" status="i">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                      <td>${policy.policyName}</td>
                      <td>${policy.cookieName}</td>
                      <td class="buttons">
                        <g:form>
                          <input type="hidden" name="loadBalancerName" value="${loadBalancer.loadBalancerName}"/>
                          <input type="hidden" name="policyName" value="${policy.policyName}"/>
                          <g:buttonSubmit class="delete" action="removePolicy" value="Remove" data-warning="Really remove policy ${policy.policyName} for ${loadBalancer.loadBalancerName}?"/>
                        </g:form>
                      </td>
                    </tr>
                  </g:each>
                </table>
              </div>
            </td>
          </tr>
        </g:if>



        <g:if test="${loadBalancer.policies.lBCookieStickinessPolicies}">
          <tr class="prop">
            <td class="name">LB Cookie Stickiness Policies:</td>
            <td class="value">
              <div class="list">
                <table class="sortable subitems">
                  <thead>
                  <tr>
                    <th>Policy Name</th>
                    <th>Cookie Name</th>
                    <th class="sorttable_nosort"></th>
                  </tr>
                  </thead>
                  <g:each var="policy" in="${loadBalancer.policies.lBCookieStickinessPolicies.sort { it.policyName }}" status="i">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                      <td>${policy.policyName}</td>
                      <td>${policy.cookieName}</td>
                      <td class="buttons">
                        <g:form>
                          <input type="hidden" name="loadBalancerName" value="${loadBalancer.loadBalancerName}"/>
                          <input type="hidden" name="policyName" value="${policy.policyName}"/>
                          <g:buttonSubmit class="delete" action="removePolicy" value="Remove" data-warning="Really remove policy ${policy.policyName} for ${loadBalancer.loadBalancerName}?"/>
                        </g:form>
                      </td>
                    </tr>
                  </g:each>
                </table>
              </div>
            </td>
          </tr>
        </g:if>



        <g:if test="${otherPolicies}">
          <tr class="prop">
            <td class="name">Policies:</td>
            <td class="value">
              <div class="list">
                <table class="sortable subitems">
                  <thead>
                  <tr>
                    <th>Policy Name</th>
                    <th>Policy Type</th>
                    <th>Attributes</th>
                    <th class="sorttable_nosort"></th>
                  </tr>
                  </thead>
                  <g:each var="policy" in="${otherPolicies.sort { it.policyName }}" status="i">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                      <td>${policy.policyName}</td>
                      <td>${policy.policyTypeName}</td>
                      <td class="variables">
                        <g:each in="${policy.policyAttributeDescriptions}" var="${attribute}">
                          <span class="tagKey">${attribute.attributeName}:</span> ${attribute.attributeValue}<br/>
                        </g:each>
                      </td>
                      <td class="buttons">
                        <g:form>
                          <input type="hidden" name="loadBalancerName" value="${loadBalancer.loadBalancerName}"/>
                          <input type="hidden" name="policyName" value="${policy.policyName}"/>
                          <g:buttonSubmit class="delete" action="removePolicy" value="Remove" data-warning="Really remove policy ${policy.policyName} for ${loadBalancer.loadBalancerName}?"/>
                        </g:form>
                      </td>
                    </tr>
                  </g:each>
                </table>
              </div>
            </td>
          </tr>
        </g:if>

        <tr class="prop">
          <td class="name">Listeners:</td>
          <td>
            <g:if test="${loadBalancer.listenerDescriptions}">
              <div class="list">
                <table class="sortable subitems">
                  <thead>
                  <tr>
                    <th>Protocol</th>
                    <th>Load Balancer Port</th>
                    <th>Instance Port</th>
                    <th>Policies</th>
                    <th class="sorttable_nosort"></th>
                  </tr>
                  </thead>
                  <g:each var="listenerDescription" in="${loadBalancer.listenerDescriptions.sort { it.listener.loadBalancerPort }}" status="i">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                      <td>${listenerDescription.listener.protocol}</td>
                      <td>${listenerDescription.listener.loadBalancerPort}</td>
                      <td>${listenerDescription.listener.instancePort}</td>
                      <td>${listenerDescription.policyNames}</td>
                      <td class="buttons">
                        <g:form>
                          <input type="hidden" name="name" value="${loadBalancer.loadBalancerName}"/>
                          <input type="hidden" name="lbPort" value="${listenerDescription.listener.loadBalancerPort}"/>
                          <g:buttonSubmit class="delete" action="removeListener" value="Remove" data-warning="Really remove listener on port ${listenerDescription.listener.loadBalancerPort}?"/>
                        </g:form>
                      </td>
                    </tr>
                  </g:each>
                </table>
              </div>
            </g:if>
          </td>
        </tr>
        <tr class="prop">
          <td class="name">Health Check:</td>
          <td class="value">
            <table>
              <tr class="prop">
                <td>
                  Target: ${loadBalancer.healthCheck.target}<br>
                  Interval: ${loadBalancer.healthCheck.interval}<br>
                  Timeout: ${loadBalancer.healthCheck.timeout}<br>
                  Unhealthy Threshhold: ${loadBalancer.healthCheck.unhealthyThreshold}<br>
                  Healthy Threshold: ${loadBalancer.healthCheck.healthyThreshold}<br>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr class="prop">
          <td class="name">Created Time:</td>
          <td class="value"><g:formatDate date="${loadBalancer.createdTime}"/></td>
        </tr>
        <tr class="prop">
          <td class="name">Instances:</td>
          <td>
            <div class="list">
              <div class="buttons"></div>
              <table class="sortable subitems">
                <thead>
                  <tr>
                    <th>Instance</th>
                    <th>Zone</th>
                    <th>Auto Scaling Group</th>
                    <th>ELB State</th>
                    <th>Reason</th>
                    <th>Description</th>
                  </tr>
                </thead>
                <tbody>
                  <g:each var="is" in="${instanceStates}">
                    <tr>
                      <td><g:linkObject type="instance" name="${is.instanceId}"/></td>
                      <td><g:availabilityZone value="${is.availabilityZone}"/></td>
                      <td><g:linkObject type="autoScaling" name="${is.autoScalingGroupName}"/></td>
                      <td>${is.state}</td>
                      <td>${is.reasonCode}</td>
                      <td>${is.description}</td>
                    </tr>
                  </g:each>
                </tbody>
              </table>
            </div>
          </td>
        </tr>
        <tr class="prop">
          <td><h2>Referenced From</h2></td>
        </tr>
        <tr class="prop">
          <td class="name">Clusters:</td>
          <td class="value">
            <table>
              <g:each in="${clusters}" var="cluster">
                <tr class="prop">
                  <td class="value"><g:linkObject type="cluster" name="${cluster}"/></td>
                </tr>
              </g:each>
            </table>
          </td>
        </tr>
        <tr class="prop">
          <td class="name">AutoScaling Groups:</td>
          <td class="value">
            <table>
              <g:each in="${groups}" var="g">
                <tr class="prop">
                  <td><g:linkObject type="autoScaling" name="${g.autoScalingGroupName}"/></td>
                  <g:if test="${g.availabilityZones.sort() != loadBalancer.availabilityZones.sort()}">
                    <td><g:render template="/common/zoneMismatch" model="[asgZones: g.availabilityZones.sort(), elbZones: loadBalancer.availabilityZones.sort()]"/></td>
                  </g:if>
                </tr>
              </g:each>
            </table>
          </td>
        </tr>
        <tr class="prop">
          <td><h2>Pattern Matches</h2></td>
        </tr>
        <tr class="prop">
          <td class="name">Application:</td>
          <td class="value"><g:linkObject type="application" name="${app?.name}"/></td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>
