;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0-4][0-9]{2}[\s][B][P][\s][0-9]{3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "097 BP\u0085859"
(define-fun Witness1 () String (str.++ "0" (str.++ "9" (str.++ "7" (str.++ " " (str.++ "B" (str.++ "P" (str.++ "\u{85}" (str.++ "8" (str.++ "5" (str.++ "9" "")))))))))))
;witness2: "018\u00A0BP 899"
(define-fun Witness2 () String (str.++ "0" (str.++ "1" (str.++ "8" (str.++ "\u{a0}" (str.++ "B" (str.++ "P" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "9" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "0" "4")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (str.to_re (str.++ "B" (str.++ "P" "")))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
