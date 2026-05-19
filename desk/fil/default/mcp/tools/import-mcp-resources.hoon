/-  mcp, spider
/+  io=strandio
^-  tool:mcp
:*  'urbit-mcp/import-mcp-resources'
    'Import MCP Resources from a desk.'
    %-  my
    :~  ['desk' [%string 'Desk to import MCP Resources from.']]
    ==
    ~['desk']
    ^-  thread-builder:tool:mcp
    |=  args=(map name:parameter:tool:mcp argument:tool:mcp)
    =/  m  (strand:spider ,vase)
    ^-  form:m
    =/  dek=(unit argument:tool:mcp)  (~(get by args) 'desk')
    ?~  dek  ~|(%missing-desk !!)
    ?>  ?=([%string *] u.dek)
    ;<    =bowl:rand
        bind:m
      get-bowl:io
    =/  resources=(list resource:mcp)
      %-  zing
      %+  murn
        %~  tap  in
        .^  (set [dude:gall ?])
            %ge
            /(scot %p our.bowl)/[p.u.dek]/(scot %da now.bowl)/$
        ==
      |=  [=dude:gall live=?]
      ^-  (unit (list resource:mcp))
      ?.  live
        ~
      =/  mule-result=(each * (list tank))
        %-  mule
        |.
        .^  (list resource:mcp)
            %gx
            /(scot %p our.bowl)/[dude]/(scot %da now.bowl)/mcp/resources/noun
        ==
      ?.  -.mule-result
        ~
      =/  resource-list  ;;((list resource:mcp) p.mule-result)
      ?~  resource-list
        ~
      `resource-list
    ?~  resources
      %-  pure:m
      !>  ^-  json
      %-  pairs:enjs:format
      :~  ['type' s+'text']
          ['text' s+(crip "No MCP Resources found in {(trip p.u.dek)}")]
      ==
    ;<  ~  bind:m
      %-  send-raw-cards:io
      %+  turn
        resources
      |=  =resource:mcp
      ~&  >>  %resource
      ~&  >>  resource
      ^-  card:agent:gall
      :*  %pass   ~
          %agent  [our.bowl %mcp-server]
          %poke   %add-resource  !>(resource)
      ==
    =/  resource-names
      %+  turn
        resources
      |=  =resource:mcp
      name.resource
    %-  pure:m
    !>  ^-  json
    %-  pairs:enjs:format
    :~  ['type' s+'text']
        ['text' s+(crip "Imported MCP Resources into %mcp-server: {<(of-wain:format resource-names)>}")]
    ==
==
