;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\w\W]{1,1500}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xF"
(define-fun Witness1 () String (str.++ "\u{0f}" ""))
;witness2: "&"
(define-fun Witness2 () String (str.++ "&" ""))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 1500) (re.range "\u{00}" "\u{ff}")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
