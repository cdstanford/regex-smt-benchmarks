;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*[a-zA-Z\s]+\,[0-9\s]+\s*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\xC,5 \xA\u0085\u00A0\xC"
(define-fun Witness1 () String (str.++ "\u{0c}" (str.++ "," (str.++ "5" (str.++ " " (str.++ "\u{0a}" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "\u{0c}" "")))))))))
;witness2: "\u0085,\xC\u00A0\u00A0"
(define-fun Witness2 () String (str.++ "\u{85}" (str.++ "," (str.++ "\u{0c}" (str.++ "\u{a0}" (str.++ "\u{a0}" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
