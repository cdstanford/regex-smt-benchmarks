(declare-const x String)
(assert (str.in_re x (
    (_ re.loop 30 30)
    (re.union (str.to_re "aaa") (str.to_re "bbb"))
)))
(check-sat)