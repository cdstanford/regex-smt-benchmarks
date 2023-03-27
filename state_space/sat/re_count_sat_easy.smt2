(set-logic QF_S)
(declare-const x String)
(assert (str.in_re x ((_ re.^ 5) (str.to_re "bazz"))))
(check-sat)
