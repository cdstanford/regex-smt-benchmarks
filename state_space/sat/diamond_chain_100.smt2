(declare-const x String)
(assert (str.in_re x (
    (_ re.loop 100 100)
    (re.union (str.to_re "aaa") (str.to_re "bbb"))
)))
(check-sat)
