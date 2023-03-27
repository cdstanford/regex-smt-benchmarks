;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\(?\+45\)?)?)(\s?\d{2}\s?\d{2}\s?\d{2}\s?\d{2})$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(+45)0824 8019"
(define-fun Witness1 () String (str.++ "(" (str.++ "+" (str.++ "4" (str.++ "5" (str.++ ")" (str.++ "0" (str.++ "8" (str.++ "2" (str.++ "4" (str.++ " " (str.++ "8" (str.++ "0" (str.++ "1" (str.++ "9" "")))))))))))))))
;witness2: "+45\u0085478441\u008594"
(define-fun Witness2 () String (str.++ "+" (str.++ "4" (str.++ "5" (str.++ "\u{85}" (str.++ "4" (str.++ "7" (str.++ "8" (str.++ "4" (str.++ "4" (str.++ "1" (str.++ "\u{85}" (str.++ "9" (str.++ "4" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.opt (re.range "(" "("))(re.++ (str.to_re (str.++ "+" (str.++ "4" (str.++ "5" "")))) (re.opt (re.range ")" ")")))))(re.++ (re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 2 2) (re.range "0" "9"))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
