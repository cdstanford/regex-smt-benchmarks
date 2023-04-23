;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (.*)-----(BEGIN|END)([^-]*)-----(.*)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "D-----END-----\u00E9\u00CEq\u00C9"
(define-fun Witness1 () String (str.++ "D" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "E" (str.++ "N" (str.++ "D" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "\u{e9}" (str.++ "\u{ce}" (str.++ "q" (str.++ "\u{c9}" "")))))))))))))))))))
;witness2: "-----BEGIN-----"
(define-fun Witness2 () String (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "B" (str.++ "E" (str.++ "G" (str.++ "I" (str.++ "N" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" ""))))))))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (str.to_re (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" ""))))))(re.++ (re.union (str.to_re (str.++ "B" (str.++ "E" (str.++ "G" (str.++ "I" (str.++ "N" "")))))) (str.to_re (str.++ "E" (str.++ "N" (str.++ "D" "")))))(re.++ (re.* (re.union (re.range "\u{00}" ",") (re.range "." "\u{ff}")))(re.++ (str.to_re (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" "")))))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
