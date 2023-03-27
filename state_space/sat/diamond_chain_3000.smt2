(set-logic QF_S)
(declare-const x String)
(assert (str.in_re x (
    (_ re.loop 3000 3000)
    (re.union (str.to_re "aaa") (str.to_re "bbb"))
)))
(check-sat)
