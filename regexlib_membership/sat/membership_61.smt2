;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{2}\s?(\d{2})?(-)?([A-Z]{1}|\d{1})?([A-Z]{1}|\d{1})?( )?(\d{4}))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "RT\u008584E1889"
(define-fun Witness1 () String (str.++ "R" (str.++ "T" (str.++ "\u{85}" (str.++ "8" (str.++ "4" (str.++ "E" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "9" "")))))))))))
;witness2: "FE\u0085939 8988"
(define-fun Witness2 () String (str.++ "F" (str.++ "E" (str.++ "\u{85}" (str.++ "9" (str.++ "3" (str.++ "9" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.opt (re.union (re.range "0" "9") (re.range "A" "Z")))(re.++ (re.opt (re.range " " " ")) ((_ re.loop 4 4) (re.range "0" "9"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
