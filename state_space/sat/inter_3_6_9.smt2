(declare-const x String)
(assert (str.in_re x (re.inter
    ((_ re.^ 3) (re.++ (re.* re.allchar) (str.to_re "a")))
    ((_ re.^ 6) (re.++ (re.* re.allchar) (str.to_re "a")))
    ((_ re.^ 9) (re.++ (re.* re.allchar) (str.to_re "a")))
)))
(check-sat)
