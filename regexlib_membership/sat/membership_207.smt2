;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [()+-.0-9]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00AF\u00BA97"
(define-fun Witness1 () String (seq.++ "\xaf" (seq.++ "\xba" (seq.++ "9" (seq.++ "7" "")))))
;witness2: "\u00EB\u00AD\u00F7(%"
(define-fun Witness2 () String (seq.++ "\xeb" (seq.++ "\xad" (seq.++ "\xf7" (seq.++ "(" (seq.++ "%" ""))))))

(assert (= regexA (re.* (re.union (re.range "(" ")")(re.union (re.range "+" ".") (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
