(set-logic QF_S)
(declare-const x String)
(assert (str.in_re x (str.to_re "qwertyuiopasdfghjklzxcvbnmqwertyuiopasdfghjklzxcvbnmqwertyuiopasdfghjklzxcvbnm")))
(check-sat)
