;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \\[\\w{2}\\]
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\2\u00A5j$"
(define-fun Witness1 () String (str.++ "\u{5c}" (str.++ "2" (str.++ "\u{a5}" (str.++ "j" (str.++ "$" ""))))))
;witness2: "\u00A4 \w\'\x1D\u008C\x11"
(define-fun Witness2 () String (str.++ "\u{a4}" (str.++ " " (str.++ "\u{5c}" (str.++ "w" (str.++ "'" (str.++ "\u{1d}" (str.++ "\u{8c}" (str.++ "\u{11}" "")))))))))

(assert (= regexA (re.++ (re.range "\u{5c}" "\u{5c}") (re.union (re.range "2" "2")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "w" "w")(re.union (re.range "{" "{") (re.range "}" "}"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
