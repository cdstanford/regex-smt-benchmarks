;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(\d{0,2})(\.?(\d*))?\s*\%?\s*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9 \x9"
(define-fun Witness1 () String (seq.++ "9" (seq.++ " " (seq.++ "\x09" ""))))
;witness2: "3.6%"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "." (seq.++ "6" (seq.++ "%" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.opt (re.range "." ".")) (re.* (re.range "0" "9"))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "%" "%"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
