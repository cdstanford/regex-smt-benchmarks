;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^\x00-\x1f\x21-\x26\x28-\x2d\x2f-\x40\x5b-\x60\x7b-\xff]+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "L"
(define-fun Witness1 () String (str.++ "L" ""))
;witness2: "M.j ."
(define-fun Witness2 () String (str.++ "M" (str.++ "." (str.++ "j" (str.++ " " (str.++ "." ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "." ".")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
