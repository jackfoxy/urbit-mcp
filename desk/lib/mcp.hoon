/-  mcp, spider
/+  server, libstrand=strand, io=strandio
=,  strand-fail=strand-fail:strand:spider
|%
::  MCP (Model Context Protocol) - JSON-RPC 2.0 Protocol Adapter
::  This library provides a thin protocol layer that:
::  - Converts tool definitions from lib/tools to MCP JSON-RPC format
::  - Handles MCP protocol-specific requests (initialize, tools/list, tools/call)
::  - Delegates tool execution to lib/tools
::
++  rpc
  |%
  ++  result
    |=  [result=json id=(unit json)]
    %-  pairs:enjs:format
    %+  welp
      ?~(id ~ ['id' u.id]~)
    :~  ['jsonrpc' s+'2.0']
        ['result' result]
    ==
  ++  error
    |%
    ++  code
    |%
    ++  parse-error       ~.-32700
    ++  invalid-request   ~.-32600
    ++  method-not-found  ~.-32601
    ++  invalid-params    ~.-32602
    ++  internal-error    ~.-32603
    --
    ++  make
      |=  [code=@ta message=@t id=(unit json)]
      ^-  json
      %-  pairs:enjs:format
      %+  welp
        ?~(id ~ ['id' u.id]~)
      :~  ['jsonrpc' s+'2.0']
          :-  'error'
          %-  pairs:enjs:format
          :~  ['code' n+code]
              ['message' s+message]
          ==
      ==
    ++  parse
      |=  [message=@t id=(unit json)]
      (make parse-error:code message id)
    ++  request
      |=  [message=@t id=(unit json)]
      (make invalid-request:code message id)
    ++  method
      |=  [message=@t id=(unit json)]
      (make method-not-found:code message id)
    ++  params
      |=  [message=@t id=(unit json)]
      (make invalid-params:code message id)
    ++  internal
      |=  [message=@t id=(unit json)]
      (make internal-error:code message id)
    --
  --
::
::  MCP-specific response helpers
::
++  mcp-text-result
  |=  [text=@t id=(unit json)]
  %-  pairs:enjs:format
  %+  welp
    ?~(id ~ ['id' u.id]~)
  :~  ['jsonrpc' s+'2.0']
      :-  'result'
      %-  pairs:enjs:format
      :~  :-  'content'
          :-  %a
          :~  %-  pairs:enjs:format
              :~  ['type' s+'text']
                  ['text' s+text]
              ==
          ==
      ==
  ==
::
++  prompt-messages-to-json
  |=  messages=(list message:prompt:mcp)
  ^-  json
  :-  %a
  %+  turn
    messages
  |=  =message:prompt:mcp
  ^-  json
  %-  pairs:enjs:format
  :~  ['role' s+role.message]
      :-  'content'
      %-  pairs:enjs:format
      :~  ['type' s+type.content.message]
          ?~  text.content.message
            ['text' s+'']
          ['text' s+u.text.content.message]
      ==
  ==
--
