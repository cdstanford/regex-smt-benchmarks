;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\u0081-\uFFFF]{1,}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00CF"
(define-fun Witness1 () String (str.++ "\u{cf}" ""))
;witness2: "\u00FF\u00EE"
(define-fun Witness2 () String (str.++ "\u{ff}" (str.++ "\u{ee}" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "\u{81}" "\u{ff}")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
