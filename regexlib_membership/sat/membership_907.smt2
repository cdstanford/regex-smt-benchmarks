;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\+){1}[1-9]{1}[0-9]{0,1}[0-9]{0,1}(\s){1}[\(]{1}[1-9]{1}[0-9]{1,5}[\)]{1}[\s]{1})[1-9]{1}[0-9]{4,9}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+89\u0085(83) 89839"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "8" (seq.++ "9" (seq.++ "\x85" (seq.++ "(" (seq.++ "8" (seq.++ "3" (seq.++ ")" (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "9" "")))))))))))))))
;witness2: "+39\u0085(21)\u008598890"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "3" (seq.++ "9" (seq.++ "\x85" (seq.++ "(" (seq.++ "2" (seq.++ "1" (seq.++ ")" (seq.++ "\x85" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "0" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "+" "+")(re.++ (re.range "1" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "(" "(")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 1 5) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 4 9) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
