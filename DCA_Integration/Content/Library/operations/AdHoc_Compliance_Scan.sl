########################################################################################################################
#!!
#! @input resourceuuid: dca resource uuid from subscription
#! @input policyuuid: static, already set in DCA "CIS"
#! @input jobtype: POLICY_REMEDIATE or POLICY_SCAN
#!!#
########################################################################################################################
namespace: operations
flow:
  name: AdHoc_Compliance_Scan
  inputs:
    - resourceuuid
    - policyuuid: '3'
    - jobtype: POLICY_SCAN
  workflow:
    - http_client_action:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: "${'http://10.0.46.16/utils.php?action=AdHocJob&resourceuuid=' + resourceuuid + '&policyuuid=' + policyuuid +'&jobtype=' + jobtype}"
            - method: get
        publish: []
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      http_client_action:
        x: 216
        y: 197
        navigate:
          5ca87300-c79a-1167-c52f-bf2755a5515c:
            targetId: 20957fa3-ccc3-1fe3-9b76-77f2f30ec4a1
            port: FAILURE
          1efbf12d-75e7-0a62-4bcc-8bd8ef27e00c:
            targetId: 686da8d3-9c69-d29d-e7b6-ff99af97047b
            port: SUCCESS
    results:
      SUCCESS:
        686da8d3-9c69-d29d-e7b6-ff99af97047b:
          x: 486
          y: 170
      FAILURE:
        20957fa3-ccc3-1fe3-9b76-77f2f30ec4a1:
          x: 225
          y: 467
