;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*\$AVE|\$ave.*
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "$aveQ#S\u00E9+"
(define-fun Witness1 () String (str.++ "$" (str.++ "a" (str.++ "v" (str.++ "e" (str.++ "Q" (str.++ "#" (str.++ "S" (str.++ "\u{e9}" (str.++ "+" ""))))))))))
;witness2: "$ave"
(define-fun Witness2 () String (str.++ "$" (str.++ "a" (str.++ "v" (str.++ "e" "")))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re (str.++ "$" (str.++ "A" (str.++ "V" (str.++ "E" "")))))) (re.++ (str.to_re (str.++ "$" (str.++ "a" (str.++ "v" (str.++ "e" ""))))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
