;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d*\s*\-?\s*\d*)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0085\u00A0\u00A0\x9"
(define-fun Witness1 () String (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "\u{09}" "")))))
;witness2: "\u0085\u0085\u00A0\xA\u00859"
(define-fun Witness2 () String (str.++ "\u{85}" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "\u{0a}" (str.++ "\u{85}" (str.++ "9" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.* (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.* (re.range "0" "9")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
