;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A][Z](.?)[0-9]{4}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "AZ\u00908669"
(define-fun Witness1 () String (str.++ "A" (str.++ "Z" (str.++ "\u{90}" (str.++ "8" (str.++ "6" (str.++ "6" (str.++ "9" ""))))))))
;witness2: "AZ\x38188"
(define-fun Witness2 () String (str.++ "A" (str.++ "Z" (str.++ "\u{03}" (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "8" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "A" (str.++ "Z" "")))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
