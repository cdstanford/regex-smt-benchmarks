;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <[^>]*>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<>"
(define-fun Witness1 () String (str.++ "<" (str.++ ">" "")))
;witness2: "<O\u0093\u007F>"
(define-fun Witness2 () String (str.++ "<" (str.++ "O" (str.++ "\u{93}" (str.++ "\u{7f}" (str.++ ">" ""))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}"))) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
