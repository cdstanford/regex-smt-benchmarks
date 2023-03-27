;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = 1
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "1"
(define-fun Witness1 () String (str.++ "1" ""))
;witness2: "1\u00D98\x10"
(define-fun Witness2 () String (str.++ "1" (str.++ "\u{d9}" (str.++ "8" (str.++ "\u{10}" "")))))

(assert (= regexA (re.range "1" "1")))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
