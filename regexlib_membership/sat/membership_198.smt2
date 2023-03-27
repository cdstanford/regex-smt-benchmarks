;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zà-ïò-öù-ü]+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "ycz"
(define-fun Witness1 () String (str.++ "y" (str.++ "c" (str.++ "z" ""))))
;witness2: "i\u00FC"
(define-fun Witness2 () String (str.++ "i" (str.++ "\u{fc}" "")))

(assert (= regexA (re.++ (re.+ (re.union (re.range "a" "z")(re.union (re.range "\u{e0}" "\u{ef}")(re.union (re.range "\u{f2}" "\u{f6}") (re.range "\u{f9}" "\u{fc}"))))) (str.to_re ""))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
