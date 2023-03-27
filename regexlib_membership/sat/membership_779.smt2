;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([1-9]{1,2})?(d|D)([1-9]{1,3})((\+|-)([1-9]{1,3}))?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "H1D9-88"
(define-fun Witness1 () String (str.++ "H" (str.++ "1" (str.++ "D" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "8" ""))))))))
;witness2: "d4Y\u00CE"
(define-fun Witness2 () String (str.++ "d" (str.++ "4" (str.++ "Y" (str.++ "\u{ce}" "")))))

(assert (= regexA (re.++ (re.opt ((_ re.loop 1 2) (re.range "1" "9")))(re.++ (re.union (re.range "D" "D") (re.range "d" "d"))(re.++ ((_ re.loop 1 3) (re.range "1" "9")) (re.opt (re.++ (re.union (re.range "+" "+") (re.range "-" "-")) ((_ re.loop 1 3) (re.range "1" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
