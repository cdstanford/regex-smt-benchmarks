;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^abc]
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "g\x6\u00F7"
(define-fun Witness1 () String (str.++ "g" (str.++ "\u{06}" (str.++ "\u{f7}" ""))))
;witness2: "i\u0081"
(define-fun Witness2 () String (str.++ "i" (str.++ "\u{81}" "")))

(assert (= regexA (re.union (re.range "\u{00}" "`") (re.range "d" "\u{ff}"))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
