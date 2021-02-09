;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((<body)|(<BODY))([^>]*)>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ".<BODY\u008D>l\u00A9p"
(define-fun Witness1 () String (seq.++ "." (seq.++ "<" (seq.++ "B" (seq.++ "O" (seq.++ "D" (seq.++ "Y" (seq.++ "\x8d" (seq.++ ">" (seq.++ "l" (seq.++ "\xa9" (seq.++ "p" ""))))))))))))
;witness2: "<BODY\u00E71>"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "B" (seq.++ "O" (seq.++ "D" (seq.++ "Y" (seq.++ "\xe7" (seq.++ "1" (seq.++ ">" "")))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "<" (seq.++ "b" (seq.++ "o" (seq.++ "d" (seq.++ "y" "")))))) (str.to_re (seq.++ "<" (seq.++ "B" (seq.++ "O" (seq.++ "D" (seq.++ "Y" "")))))))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff"))) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
