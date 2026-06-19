|%
++  parse
  |=  uri=@t
  ^-  (unit path)
  =/  parts=(list @t)
    %+  turn
      (split "/" (slag (lent "scry://") (trip uri)))
    crip
  ?~  parts
    ~
  =/  care=@t               i.parts
  =/  after-care=(list @t)  t.parts
  ?~  after-care
    ~
  ?+  care  ~
      %'gx'
    `(welp /gx/[i.after-care] (to-path t.after-care))
  ::
      %'cx'
    =/  after-desk=(list @t)  t.after-care
    ?~  after-desk
      ~
    ?~  t.after-desk
      ~
    =/  case-knot=(unit @ta)  (parse-case i.after-desk)
    ?~  case-knot
      ~
    `(welp /cx/[i.after-care]/[u.case-knot] (to-path t.after-desk))
  ==
::
++  parse-case
  |=  case-text=@t
  ^-  (unit @ta)
  =/  parsed  (rust (trip case-text) nuck:so)
  ?~  parsed
    ~
  ?.  ?=([%$ *] u.parsed)
    ~
  =/  =dime  p.u.parsed
  ?+  -.dime  `(scot %tas (@tas +.dime))
    %da  `(scot %da (@da +.dime))
    %ud  `(scot %ud (@ud +.dime))
    %uv  `(scot %uv (@uv +.dime))
  ==
::
++  to-path
  |=  parts=(list @t)
  ^-  path
  %-  stab
  %-  crip
  %-  tape
  :-('/' (join '/' parts))
::
++  split
  |=  [sep=tape =tape]
  ^-  (list ^tape)
  =|  res=(list ^tape)
  |-
  ?~  tape
    (flop res)
  =/  off  (find sep tape)
  ?~  off
    (flop [`^tape`tape `(list ^tape)`res])
  %=  $
    res   [(scag `@ud`(need off) `^tape`tape) res]
    tape  (slag +(`@ud`(need off)) `^tape`tape)
  ==
--
