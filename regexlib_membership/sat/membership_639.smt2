;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0-9]|1[0-9]|2[0-4])(\.[0-9][0-9]?)?)$|([2][5](\.[0][0]?)?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B6\u0098\u00BA\x18M25.00"
(define-fun Witness1 () String (seq.++ "\xb6" (seq.++ "\x98" (seq.++ "\xba" (seq.++ "\x18" (seq.++ "M" (seq.++ "2" (seq.++ "5" (seq.++ "." (seq.++ "0" (seq.++ "0" "")))))))))))
;witness2: "21"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "1" "")))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "4")))) (re.opt (re.++ (re.range "." ".")(re.++ (re.range "0" "9") (re.opt (re.range "0" "9")))))) (str.to_re ""))) (re.++ (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.opt (re.++ (str.to_re (seq.++ "." (seq.++ "0" ""))) (re.opt (re.range "0" "0"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
