;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((<body)|(<BODY))([^>]*)>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".<BODY\u008D>l\u00A9p"
(define-fun Witness1 () String (str.++ "." (str.++ "<" (str.++ "B" (str.++ "O" (str.++ "D" (str.++ "Y" (str.++ "\u{8d}" (str.++ ">" (str.++ "l" (str.++ "\u{a9}" (str.++ "p" ""))))))))))))
;witness2: "<BODY\u00E71>"
(define-fun Witness2 () String (str.++ "<" (str.++ "B" (str.++ "O" (str.++ "D" (str.++ "Y" (str.++ "\u{e7}" (str.++ "1" (str.++ ">" "")))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "<" (str.++ "b" (str.++ "o" (str.++ "d" (str.++ "y" "")))))) (str.to_re (str.++ "<" (str.++ "B" (str.++ "O" (str.++ "D" (str.++ "Y" "")))))))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}"))) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
