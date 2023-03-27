;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d{3}\s?\d{3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "405375"
(define-fun Witness1 () String (str.++ "4" (str.++ "0" (str.++ "5" (str.++ "3" (str.++ "7" (str.++ "5" "")))))))
;witness2: "399\xA499"
(define-fun Witness2 () String (str.++ "3" (str.++ "9" (str.++ "9" (str.++ "\u{0a}" (str.++ "4" (str.++ "9" (str.++ "9" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
