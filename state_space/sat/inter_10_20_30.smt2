(set-logic QF_S)
(declare-const x String)
(assert (str.in_re x (re.inter
    ((_ re.^ 10) (re.++ (re.* re.allchar) (str.to_re "a")))
    ((_ re.^ 20) (re.++ (re.* re.allchar) (str.to_re "a")))
    ((_ re.^ 30) (re.++ (re.* re.allchar) (str.to_re "a")))
)))
(check-sat)
