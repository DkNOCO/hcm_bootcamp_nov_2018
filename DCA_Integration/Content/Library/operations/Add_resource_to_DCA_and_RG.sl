########################################################################################################################
#!!
#! @input ipaddress: ip address or FQDN
#!!#
########################################################################################################################
namespace: operations
flow:
  name: Add_resource_to_DCA_and_RG
  inputs:
    - ipaddress
    - groupuuid: 422e3dabc1003243bb0df5470ae93727
    - credentialid: 4a8fe275-71e8-4f13-8f12-b341916ee022
  workflow:
    - http_client_action:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: "${'http://10.0.46.16/utils.php?action=ImportLinuxResource&credentialid=' + credentialid + '&FQDNorIP=' + ipaddress}"
            - method: get
        publish:
          - resourceuuid: '${return_result}'
        navigate:
          - SUCCESS: http_client_action_1
          - FAILURE: FAILURE
    - http_client_action_1:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: "${'http://10.0.46.16/utils.php?action=AddResourceToGroup&groupuuid=' + groupuuid + '&resourceuuid=' + resourceuuid}"
            - method: get
        publish: []
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  outputs:
    - resourceuuid: '${resourceuuid}'
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      http_client_action:
        x: 65
        y: 267
        navigate:
          e6499516-1981-2588-5238-a1509b6dc40b:
            targetId: 4cc2c819-e86a-08be-d2f0-f3108c45e743
            port: FAILURE
      http_client_action_1:
        x: 370
        y: 265
        navigate:
          f1d28008-6433-b3a5-e0c9-8462c0457a37:
            targetId: 4cc2c819-e86a-08be-d2f0-f3108c45e743
            port: FAILURE
          a8d80886-0a13-e55a-d18b-acecfc0b2e83:
            targetId: eeddb4d9-b17a-1093-2f9a-55ee1f3d8325
            port: SUCCESS
    results:
      SUCCESS:
        eeddb4d9-b17a-1093-2f9a-55ee1f3d8325:
          x: 365
          y: 41
      FAILURE:
        4cc2c819-e86a-08be-d2f0-f3108c45e743:
          x: 193
          y: 444
