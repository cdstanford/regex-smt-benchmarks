(declare-const x String)
(assert (str.in_re x ((_ re.^ 10000) (str.to_re "bazz"))))
(check-sat)
