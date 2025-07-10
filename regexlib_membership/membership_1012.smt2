;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)*[a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "i-3"
(define-fun Witness1 () String (str.++ "i" (str.++ "-" (str.++ "3" ""))))
;witness2: "41CW8"
(define-fun Witness2 () String (str.++ "4" (str.++ "1" (str.++ "C" (str.++ "W" (str.++ "8" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ ((_ re.loop 0 61) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." "."))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ ((_ re.loop 0 61) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
