;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((0[123456789]|1[0-2])(0[1-3]|1[0-9]|2[0-9]))|((0[13456789]|1[0-2])(30))|((0[13578]|1[02])(31))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00C5\x13D1231"
(define-fun Witness1 () String (str.++ "\u{c5}" (str.++ "\u{13}" (str.++ "D" (str.++ "1" (str.++ "2" (str.++ "3" (str.++ "1" ""))))))))
;witness2: "1231"
(define-fun Witness2 () String (str.++ "1" (str.++ "2" (str.++ "3" (str.++ "1" "")))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2"))) (re.union (re.++ (re.range "0" "0") (re.range "1" "3"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "9"))))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1") (re.range "3" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2"))) (str.to_re (str.++ "3" (str.++ "0" "")))) (re.++ (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2")))) (str.to_re (str.++ "3" (str.++ "1" "")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
