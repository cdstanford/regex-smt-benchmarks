;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]{1,2}[:][0-9]{1,2}[:]{0,2}[0-9]{0,2}[\s]{0,}[AMPamp]{0,2})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9:31::5\u00EA"
(define-fun Witness1 () String (str.++ "9" (str.++ ":" (str.++ "3" (str.++ "1" (str.++ ":" (str.++ ":" (str.++ "5" (str.++ "\u{ea}" "")))))))))
;witness2: "88:4\u0085\xC \u00A0apD\x8S\u0093\u00CB"
(define-fun Witness2 () String (str.++ "8" (str.++ "8" (str.++ ":" (str.++ "4" (str.++ "\u{85}" (str.++ "\u{0c}" (str.++ " " (str.++ "\u{a0}" (str.++ "a" (str.++ "p" (str.++ "D" (str.++ "\u{08}" (str.++ "S" (str.++ "\u{93}" (str.++ "\u{cb}" ""))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ ((_ re.loop 0 2) (re.range ":" ":"))(re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) ((_ re.loop 0 2) (re.union (re.range "A" "A")(re.union (re.range "M" "M")(re.union (re.range "P" "P")(re.union (re.range "a" "a")(re.union (re.range "m" "m") (re.range "p" "p")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
