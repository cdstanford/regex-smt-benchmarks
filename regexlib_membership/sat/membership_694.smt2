;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <!*[^<>]*>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0087\u00A3<!!>"
(define-fun Witness1 () String (str.++ "\u{87}" (str.++ "\u{a3}" (str.++ "<" (str.++ "!" (str.++ "!" (str.++ ">" "")))))))
;witness2: "\u00F0<>"
(define-fun Witness2 () String (str.++ "\u{f0}" (str.++ "<" (str.++ ">" ""))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.range "!" "!"))(re.++ (re.* (re.union (re.range "\u{00}" ";")(re.union (re.range "=" "=") (re.range "?" "\u{ff}")))) (re.range ">" ">"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
