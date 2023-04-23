;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(-?\$?([1-9]\d{0,2}(,\d{3})*|[1-9]\d*|0|)(.\d{1,2})?|\(\$?([1-9]\d{0,2}(,\d{3})*|[1-9]\d*|0|)(.\d{1,2})?\))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "5"
(define-fun Witness1 () String (str.++ "5" ""))
;witness2: "$926"
(define-fun Witness2 () String (str.++ "$" (str.++ "9" (str.++ "2" (str.++ "6" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.range "$" "$"))(re.++ (re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))))(re.union (re.++ (re.range "1" "9") (re.* (re.range "0" "9")))(re.union (re.range "0" "0") (str.to_re "")))) (re.opt (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) ((_ re.loop 1 2) (re.range "0" "9"))))))) (re.++ (re.range "(" "(")(re.++ (re.opt (re.range "$" "$"))(re.++ (re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 0 2) (re.range "0" "9")) (re.* (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))))(re.union (re.++ (re.range "1" "9") (re.* (re.range "0" "9")))(re.union (re.range "0" "0") (str.to_re ""))))(re.++ (re.opt (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) ((_ re.loop 1 2) (re.range "0" "9")))) (re.range ")" ")")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
