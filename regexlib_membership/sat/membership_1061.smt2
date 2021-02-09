;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([+]31|0031)\s\(0\)([0-9]{9})|([+]31|0031)\s0([0-9]{9})|0([0-9]{9}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0808881286"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "1" (seq.++ "2" (seq.++ "8" (seq.++ "6" "")))))))))))
;witness2: "+31 0971899648"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "3" (seq.++ "1" (seq.++ " " (seq.++ "0" (seq.++ "9" (seq.++ "7" (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "4" (seq.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (str.to_re (seq.++ "+" (seq.++ "3" (seq.++ "1" "")))) (str.to_re (seq.++ "0" (seq.++ "0" (seq.++ "3" (seq.++ "1" ""))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (str.to_re (seq.++ "(" (seq.++ "0" (seq.++ ")" "")))) ((_ re.loop 9 9) (re.range "0" "9")))))(re.union (re.++ (re.union (str.to_re (seq.++ "+" (seq.++ "3" (seq.++ "1" "")))) (str.to_re (seq.++ "0" (seq.++ "0" (seq.++ "3" (seq.++ "1" ""))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.range "0" "0") ((_ re.loop 9 9) (re.range "0" "9"))))) (re.++ (re.range "0" "0") ((_ re.loop 9 9) (re.range "0" "9"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
