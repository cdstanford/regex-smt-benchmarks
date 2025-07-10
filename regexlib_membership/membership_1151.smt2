;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[ .a-zA-Z0-9:-]{1,150}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "wH"
(define-fun Witness1 () String (str.++ "w" (str.++ "H" "")))
;witness2: ":"
(define-fun Witness2 () String (str.++ ":" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 150) (re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "0" ":")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
